//
//  LockedField.swift
//  NFC afregelen
//
//  Created by Damiaan Dufaux on 11/06/15.
//  Copyright (c) 2015 Romuald Dufaux. All rights reserved.
//

import Cocoa

class LockedField: NSTextField {

	var onFocus: (()->())?
	var lock: LockButton!
	var inFocus = false
	
	override func becomeFirstResponder() -> Bool {
		let becomes = super.becomeFirstResponder()
		if  becomes {
			onFocus?()
			inFocus = true
		}
		return becomes
	}
	
	override func resignFirstResponder() -> Bool {
		let filter = super.resignFirstResponder()
		if filter {
			inFocus = false
		}
		return filter
	}
    
}
