//
//  ViewController.swift
//  NFC afregelen
//
//  Created by Romuald Dufaux on 10/06/15.
//  Copyright (c) 2015 Romuald Dufaux. All rights reserved.
//

import Cocoa

let π = M_PI

enum Field: Int {
	case frequency = 0, capacity, inductivity
}

class ViewController: NSViewController {
	@IBOutlet weak var frequencyField: FocusField!
	@IBOutlet weak var capacityField: FocusField!
	@IBOutlet weak var inductivityField: FocusField!

	var lock = Field.capacity {
		didSet {
			if oldValue != lock {
				lockObjC = lock.rawValue
			}
		}
	}
	
	dynamic var lockObjC: Int {
		get {return lock.rawValue}
		set {lock = Field(rawValue: newValue)!}
	}
	
	var f: Double { get { return Double(frequency ?? 1) }}
	var i: Double { get { return Double(inductivity ?? 1) }}
	var c: Double { get { return Double(capacity ?? 1) }}
	
	dynamic var frequency: NSNumber? {
		didSet {
			switch lock {
			case .capacity:
				setI(1.0 / pow(2.0 * π * f, 2) * c)
			case .inductivity:
				setC(1.0 / pow(2.0 * π * f, 2) * i)
			default:
				assertionFailure("lock is wrong")
			}
		}
	}
	
	dynamic var capacity: NSNumber? {
		didSet {
			switch lock {
			case .frequency:
				setI(1.0 / pow(2.0 * π * f, 2) * c)
			case .inductivity:
				setF(1/(2*π*sqrt(i*c)))
			default:
				assertionFailure("lock is wrong")
			}
		}
	}
	
	dynamic var inductivity: NSNumber? {
		didSet {
			switch lock {
			case .capacity:
				setF(1/(2*π*sqrt(i*c)))
			case .frequency:
				setC(1.0 / pow(2.0 * π * f, 2) * i)
			default:
				assertionFailure("lock is wrong")
			}
		}
	}
	
	func setF(newValue: NSNumber) {
		if frequency != newValue {
			frequency = newValue
		}
	}
	
	func setC(newValue: NSNumber) {
		if capacity != newValue {
			capacity = newValue
		}
	}
	
	func setI(newValue: NSNumber) {
		if inductivity != newValue {
			inductivity = newValue
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		frequencyField.focusDelegate = EventDelegate {self.lock = .capacity}
		capacityField.focusDelegate = EventDelegate {self.lock = .inductivity}
		inductivityField.focusDelegate = EventDelegate {self.lock = .frequency}
	}
	
	
}
