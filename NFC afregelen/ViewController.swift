//
//  ViewController.swift
//  NFC afregelen
//
//  Created by Romuald Dufaux on 10/06/15.
//  Copyright (c) 2015 Romuald Dufaux. All rights reserved.
//

import Cocoa

let π2 = M_PI * 2.0

enum Variable: Int {
	case frequency = 0, capacity, inductivity
}

let variables: Set<Variable> = [.frequency, .inductivity, .capacity]

class ViewController: NSViewController {
	@IBOutlet var frequencyField: LockedField!
	@IBOutlet var capacityField: LockedField!
	@IBOutlet var inductivityField: LockedField!
	
	func calculateInductivity() { L = 1.0 / (pow(π2 * f, 2.0) * C) }
	func calculateCapacity()    { C = 1.0 / (pow(π2 * f, 2.0) * L) }
	func calculateFrequency()   { f = 1.0 / (π2 * sqrt(L * C)) }
	
	@IBAction func update(sender: LockedField) {
		let variable = variables.subtract([getVariable(sender), lock]).first!
		updateField(variable)
	}
	
	var lock = Variable.capacity {
		willSet {
			willChangeValueForKey("frequencyLock")
			willChangeValueForKey("capacityLock")
			willChangeValueForKey("inductivityLock")
		}
		didSet {
			didChangeValueForKey("frequencyLock")
			didChangeValueForKey("capacityLock")
			didChangeValueForKey("inductivityLock")
		}
	}
	
	@IBAction func clickLock(sender: LockButton) {
		if !(sender.control as! LockedField).inFocus {
			lock = getVariable(sender.control as! LockedField)
		}
	}
	
	dynamic var frequencyLock:   String {get { return lock == .frequency   ? "🔒" : "🔓" }}
	dynamic var capacityLock:    String {get { return lock == .capacity    ? "🔒" : "🔓" }}
	dynamic var inductivityLock: String {get { return lock == .inductivity ? "🔒" : "🔓" }}

	dynamic var frequency: NSNumber = 0
	dynamic var capacity:  NSNumber = 0
	dynamic var inductivity: NSNumber = 0
	
	override func viewDidLoad() {
		for variable in variables {
			getField(variable).onFocus = { self.lock = variables.subtract([variable]).first! }
		}
	}
}

extension ViewController {
	func getField(type: Variable) -> LockedField {
		switch type {
		case .frequency: return frequencyField
		case .capacity: return capacityField
		case .inductivity: return inductivityField
		}
	}

	func updateField(type: Variable) {
		switch type {
		case .frequency: calculateFrequency()
		case .capacity:  calculateCapacity()
		case .inductivity: calculateInductivity()
		}
	}
	
	func getVariable(field: LockedField) -> Variable {
		switch field {
		case frequencyField:
			return .frequency
		case capacityField:
			return .capacity
		case inductivityField:
			return .inductivity
		default:
			assertionFailure("incorrect field")
			return .capacity
		}
	}

	var f: Double {
		get { return frequency.doubleValue * 1000000.0 }
		set { frequency = newValue / 1000000.0 }
	}
	var L: Double {
			get { return Double(inductivity) / 1000000.0 }
			set { inductivity = newValue * 1000000.0 }
	}
	var C: Double {
			get { return Double(capacity) / 1000000000000.0 }
			set { capacity = newValue * 1000000000000.0 }
	}
}

func + (left: NSNumber, right: NSNumber) -> NSNumber {
	return NSNumber(float: left.floatValue + right.floatValue)
}
func - (left: NSNumber, right: NSNumber) -> NSNumber {
	return NSNumber(float: left.floatValue - right.floatValue)
}
func * (left: NSNumber, right: NSNumber) -> NSNumber {
	return NSNumber(float: left.floatValue * right.floatValue)
}
func * (left: Double, right: NSNumber) -> NSNumber {
	return NSNumber(double: left * right.doubleValue)
}
func * (left: Double, right: NSNumber) -> Double {
	return left * right.doubleValue
}
func * (left: NSNumber, right: NSNumber) -> Double {
	return left.doubleValue * right.doubleValue
}
func / (left: NSNumber, right: NSNumber) -> NSNumber {
	return NSNumber(float: left.floatValue / right.floatValue)
}