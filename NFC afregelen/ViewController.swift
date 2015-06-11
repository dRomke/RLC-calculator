//
//  ViewController.swift
//  NFC afregelen
//
//  Created by Romuald Dufaux on 10/06/15.
//  Copyright (c) 2015 Romuald Dufaux. All rights reserved.
//

import Cocoa

enum Variable: Int {
	case frequency = 0, capacity, inductivity
}

let variables: Set<Variable> = [.frequency, .capacity, .inductivity]

class ViewController: NSViewController {
	@IBOutlet var frequencyField: NSTextField!
	@IBOutlet var capacityField: NSTextField!
	@IBOutlet var inductivityField: NSTextField!
	
	func calculateInductivity() {
		inductivity = frequency - capacity
	}
	
	func calculateCapacity() {
		capacity = frequency - inductivity
	}
	
	func calculateFrequency() {
		frequency = inductivity + capacity
	}
	
	@IBAction func update(sender: NSTextField) {
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
		lock = getVariable(sender.control as! NSTextField)
	}
	
	dynamic var frequencyLock:   String {get { return lock == .frequency   ? "🔒" : "🔓" }}
	dynamic var capacityLock:    String {get { return lock == .capacity    ? "🔒" : "🔓" }}
	dynamic var inductivityLock: String {get { return lock == .inductivity ? "🔒" : "🔓" }}

	dynamic var frequency: NSNumber = 0
	dynamic var capacity:  NSNumber = 0
	dynamic var inductivity: NSNumber = 0
	
}

extension ViewController {
	func getField(type: Variable) -> NSTextField {
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
	
	func getVariable(field: NSTextField) -> Variable {
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
func / (left: NSNumber, right: NSNumber) -> NSNumber {
	return NSNumber(float: left.floatValue / right.floatValue)
}
func ^ (left: NSNumber, right: NSNumber) -> NSNumber {
	return NSNumber(float: pow(left.floatValue, right.floatValue))
}
