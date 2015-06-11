//
//  LockButton.swift
//  NFC afregelen
//
//  Created by Damiaan Dufaux on 11/06/15.
//  Copyright (c) 2015 Romuald Dufaux. All rights reserved.
//

import Cocoa

class LockButton: NSButton {
	@IBOutlet var control: NSControl! {
		didSet {
			if let lockField = control as? LockedField {
				lockField.lock = self
			}
		}
	}
}
