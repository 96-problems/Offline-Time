//
//  AppDelegate.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa
import Foundation
import CoreWLAN

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popupMenu: PopupMenu?
    
    
    var popupWindowController: NSWindowController?
    var menuViewController: NSViewController?
    var timer: NSTimer?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.setupStatusItem()
        
        var objects: NSArray?
//        var popupMenu = NSBundle.mainBundle().loadNibNamed("PopupMenu", owner: self, topLevelObjects: &objects)[0] as! PopupMenu
//        self.statusItem.menu = popupMenu
        //        self.statusItem.title = "Offline Time"
        
//        var error: NSError?
//        let wifi = CWInterface(interfaceName: "en0")
//        let result = wifi.setPower(false, error: &error)
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        return NSApplicationTerminateReply.TerminateNow
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func setupStatusItem() {
        if self.statusItem == nil {
            self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
        }
        if let button = self.statusItem!.button {
            button.image = NSImage(named: "StatusBarButtonImage")
//            button.action = Selector("togglePanel:")
        }
        
        //  Get menu
        var views: NSArray?
        let foo = NSBundle.mainBundle().loadNibNamed("PopupMenu", owner: self, topLevelObjects: &views)
        var menu: PopupMenu!
        for view in views! {
            if view.isMemberOfClass(PopupMenu) {
                menu = view as! PopupMenu
            }
        }
        self.popupMenu = menu
        
        //  Get sliderView
        var views2: NSArray?
        let foo2 = NSBundle.mainBundle().loadNibNamed("SliderViewController", owner: self, topLevelObjects: &views2)
        var sliderView: NSView!
        for view in views2! {
            if view.isMemberOfClass(SliderView) {
                sliderView = view as! SliderView
            }
        }
        
//        let slider = NSSlider(frame: NSMakeRect(0, 0, 195, 20))
        self.popupMenu!.startMenuItem.enabled = true
        self.popupMenu!.sliderMenuItem.view = sliderView
        self.statusItem?.menu = self.popupMenu
    }

    //  MARK: - Actions
    @IBAction func togglePanel(sender: AnyObject) {
        println("Toggling panel")
//        let currentEvent: NSEvent! = NSApp.currentEvent
//        let eventFrame = currentEvent.
//        let eventOrigin = eventFrame.origin
//        let eventSize = eventFrame.size
        

    }
    
    @IBAction func onSelectTime(sender: AnyObject) {
    }

}