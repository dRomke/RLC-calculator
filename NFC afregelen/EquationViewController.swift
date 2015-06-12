//
//  EquationViewController.swift
//  NFC afregelen
//
//  Created by Damiaan Dufaux on 11/06/15.
//  Copyright © 2015 Romuald Dufaux. All rights reserved.
//

import Cocoa

let π2 = M_PI * 2.0

class EquationViewController: NSViewController {
	
	// MARK: Outlets
	@IBOutlet var frequency: LockedField!
	@IBOutlet var inductivity: LockedField!
	@IBOutlet var capacity: LockedField!
	
	// MARK: - Equation
	var equation: Equation!

	// MARK: Variables
	func f(v: VariableStorage) -> Double {
		let (L, C) = (v[inductivity]!.µ(), v[capacity]!.p())
		return ( 1 / (π2 * sqrt(L * C)) ).inM()
	}
	
	func L(v: VariableStorage) -> Double {
		let (f, C) = (v[frequency]!.µ(), v[capacity]!.p())
		return ( 1 / pow(π2*f, 2) / C ).inµ()
	}
	
	func C(v: VariableStorage) -> Double {
		let (L, f) = (v[inductivity]!.µ(), v[frequency]!.p())
		return ( 1 / pow(π2*f, 2) / L ).inµ()
	}
	
	// MARK: -
	
	var weak: LockedField! {
		didSet {
			oldValue?.lock.title = "🔒"
			weak.lock.title = "🔓"
		}
	}
	
	@IBAction func updateModel(sender: LockedField) {
		equation[sender, weak] = sender.doubleValue
	}
	
	@IBAction func setWeakField(sender: LockButton) {
		weak = sender.control as! LockedField
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		equation = Equation(variables: [
			frequency: (f, {self.frequency.doubleValue = $0}),
			inductivity: (L, {self.inductivity.doubleValue = $0}),
			capacity: (C, {self.capacity.doubleValue = $0})
		])
		
		weak = capacity
		
    }
}

extension Double {
	func   M() -> Double { return self*1000000 }
	func inM() -> Double { return self/1000000 }

	func µ() -> Double { return inM() }
	func inµ() -> Double { return M() }
	
	func p()   -> Double { return self / 1000000000000 }
	func inP() -> Double { return self * 1000000000000 }
}