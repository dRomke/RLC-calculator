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
	
	override func becomeFirstResponder() -> Bool {
		let becomes = super.becomeFirstResponder()
		if  becomes { onFocus?() }
		return becomes
	}
    
}
