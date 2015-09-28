//
//  AppDelegate.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa
import CoreWLAN

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var menubarController: MenubarController?
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        println("Hey")
        if let button = self.statusItem.button { 
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = Selector("togglePanel:")
        }
        
        var error: NSError?
        let wifi = CWInterface(interfaceName: "en0")
        let result = wifi.setPower(false, error: &error)
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        self.menubarController = nil
        return NSApplicationTerminateReply.TerminateNow
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    //  MARK: - Actions
    @IBAction func togglePanel(sender: AnyObject) {
        
    }

}

