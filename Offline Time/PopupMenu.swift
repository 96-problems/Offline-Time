//
//  PopupMenu.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa

class PopupMenu: NSMenu {
    
    @IBOutlet var sliderMenuItem: NSMenuItem!
    @IBOutlet var startMenuItem: NSMenuItem!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func validateMenuItem(menuItem: NSMenuItem) -> Bool {
        println(menuItem)
        return true
    }
}