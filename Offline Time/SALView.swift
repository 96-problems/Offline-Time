//
//  SALView.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa

protocol SALViewDelegate {
    func toggledSetting(state: Int)
}

class SALView: NSView {
    @IBOutlet var button: NSButton!
    
    var customDelegate: SALViewDelegate?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    @IBAction func toggleSetting(sender: NSButton) {
        Swift.print("Start At Login setting: \(sender.integerValue)")
        self.customDelegate?.toggledSetting(sender.integerValue)
    }
    
}
