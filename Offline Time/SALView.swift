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
    let APP_BUNDLE_IDENTIFIER = "com.96Problems.Offline-Time"
    
    @IBOutlet var button: NSButton!
    
    var customDelegate: SALViewDelegate?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func toggleSetting(sender: NSButton) {
        println("Start At Login setting: \(sender.integerValue)")
        self.customDelegate?.toggledSetting(sender.integerValue)
//        let loginController = StartAtLoginController(identifier: APP_BUNDLE_IDENTIFIER)
//        
//        let isLoginItem = loginController.startAtLogin
//        let shouldBeLoginItem = NSUserDefaults.standardUserDefaults().boolForKey("LaunchAtLogin")
//        
//        if (shouldBeLoginItem && !isLoginItem) {
//            loginController.startAtLogin = true
//        } else if (!shouldBeLoginItem && isLoginItem) {
//            loginController.startAtLogin = false
//        }
    }
    
}
