//
//  LockedField.swift
//  NFC afregelen
//
//  Created by Damiaan Dufaux on 11/06/15.
//  Copyright (c) 2015 Romuald Dufaux. All rights reserved.
//

import Cocoa

class LockedField: NSTextField {

	var lock: LockButton!
	
	var onFocus: (()->())?
	var inFocus: Bool {
		if let delegate: NSObject = (NSApp.keyWindow?.firstResponder as? NSText)?.delegate as? NSObject {
			return self == delegate
		}
		return false
	}
	
	override func becomeFirstResponder() -> Bool {
		let becomes = super.becomeFirstResponder()
		if  becomes { onFocus?() }
		return becomes
	}
    
}