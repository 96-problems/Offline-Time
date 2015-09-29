//
//  CustomSlider.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/29/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa

class CustomSlider: NSSlider {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    override func setNeedsDisplayInRect(invalidRect: NSRect) {
        super.setNeedsDisplayInRect(self.bounds)
    }
    
    @IBAction func darkModeChanged(sender: AnyObject) {
        self.needsDisplay = true
    }
    
    func setupListener() {
        NSDistributedNotificationCenter.defaultCenter().addObserver(self, selector: "darkModeChanged:", name: "AppleInterfaceThemeChangedNotification", object: nil)
    }
    
    deinit {
        NSDistributedNotificationCenter.defaultCenter().removeObserver(self)
    }
}
