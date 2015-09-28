//
//  SharedInstance.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Foundation

class SharedInstance {
    class func launchAtLogin() {
        let loginController = StartAtLoginController(identifier: "se.DMarby.HarpiaHelper")
        
        let isLoginItem = loginController.startAtLogin
        let shouldBeLoginItem = NSUserDefaults.standardUserDefaults().boolForKey("LaunchAtLogin")
        
        if (shouldBeLoginItem && !isLoginItem) {
            loginController.startAtLogin = true
        } else if (!shouldBeLoginItem && isLoginItem) {
            loginController.startAtLogin = false
        }
    }
}