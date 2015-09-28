//
//  PopupMenu.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa

protocol PopupMenuDelegate {
    func onToggleStartup()
    func onRequestQuit()
}

class PopupMenu: NSMenu {
    var customDelegate: PopupMenuDelegate?

    @IBOutlet var quitMenuItem: NSMenuItem!
    @IBOutlet var sliderMenuItem: NSMenuItem!
    @IBOutlet var startAtLoginMenuItem: NSMenuItem!
    var startMenuItem: NSMenuItem!

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func validateMenuItem(menuItem: NSMenuItem) -> Bool {
        return true
    }
    
    override func validateToolbarItem(theItem: NSToolbarItem) -> Bool {
        return true
    }
    
    @IBAction func toggleStartup(sender:AnyObject) {
        self.customDelegate?.onToggleStartup()
    }
    
    @IBAction func quitButtonPressed(sender: AnyObject) {
        self.customDelegate?.onRequestQuit()
    }
}
