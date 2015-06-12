//
//  Equasion.swift
//  NFC afregelen
//
//  Created by Damiaan Dufaux on 11/06/15.
//  Copyright © 2015 Romuald Dufaux. All rights reserved.
//

import Foundation

typealias VariableStorage = [NSObject: Double]
typealias VariableDeclaration = ( (VariableStorage)->Double, (Double)->Void )

class Equation {
	var variableValues = VariableStorage()
	var variableDeclarations: [NSObject: VariableDeclaration]
	
	init(variables: [NSObject: VariableDeclaration]) {
		self.variableDeclarations = variables
		for (variable, _) in variables {
			variableValues[variable] = 0
		}
	}
	
	subscript(name: NSObject) -> Double? {
		get {
			return variableValues[name]
		}
		set {
			if let newValue = newValue, _ = variableValues.indexForKey(name) {
				variableValues[name]! = newValue
				variableDeclarations[name]!.1(newValue)
			}
		}
	}
	
	subscript(name: NSObject, weakVariable: NSObject) -> Double? {
		get {
			return self[name]
		}
		set {
			if let newValue = newValue, _ = variableValues.indexForKey(weakVariable) {
				self[name] = newValue
				
				let (formula, updateHandler) = variableDeclarations[weakVariable]!
				let newWeakValue = formula(variableValues)
				
				variableValues[weakVariable]! = newWeakValue
				updateHandler(newWeakValue)
			}
		}
	}
}
