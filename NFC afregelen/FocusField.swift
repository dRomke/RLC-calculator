//
//  FocusField.swift
//  NFC afregelen
//
//  Created by Romuald Dufaux on 10/06/15.
//  Copyright (c) 2015 Romuald Dufaux. All rights reserved.
//

import Cocoa

class EventDelegate {
	var handler: () -> ()
	init(handler: () -> ()) {
		self.handler = handler
	}
}

class FocusField: NSTextField {

	var focusDelegate: EventDelegate?
	
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
		
        // Drawing code here.
    }
	
	override func becomeFirstResponder() -> Bool {
		focusDelegate?.handler()
		return super.becomeFirstResponder();
	}
    
}
