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
    
    var startAtLoginController = StartAtLoginController()
    let APP_BUNDLE_IDENTIFIER = "com.96Problems.Offline-Time"
    
    var statusItem: NSStatusItem?
    var sliderView: SliderView?
    var popupMenu: PopupMenu?
    
    var menuViewController: NSViewController?
    var timer: NSTimer?
    var runningInfinitely = false

    func applicationDidFinishLaunching(aNotification: NSNotification) {
//        self.startAtLoginController = StartAtLoginController(identifier: APP_BUNDLE_IDENTIFIER)
        self.setupStatusItem()
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        return NSApplicationTerminateReply.TerminateNow
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func setupStatusItem() {
        if self.statusItem == nil {
            self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
        }
        if let button = self.statusItem!.button {
            button.image = NSImage(named: "StatusBarButtonImage")
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
        for view in views2! {
            if view.isMemberOfClass(SliderView) {
                self.sliderView = view as? SliderView
            }
        }
        
        self.popupMenu!.sliderMenuItem.view = sliderView
        
        //  Start at Login
        var salView: SALView!
        var views3: NSArray?
        let foo3 = NSBundle.mainBundle().loadNibNamed("SALViewController", owner: self, topLevelObjects: &views3)
        for view in views3! {
            if view.isMemberOfClass(SALView) {
                salView = view as! SALView
            }
        }
        self.popupMenu!.startAtLoginMenuItem.view = salView
        
        
        //  Start button
        let startButtonMenuItem = NSMenuItem(title: "Start", action: "onSelectTime:", keyEquivalent: "")
        self.popupMenu?.startMenuItem = startButtonMenuItem
        self.popupMenu?.addItem(self.popupMenu!.startMenuItem)
        
        self.statusItem?.menu = self.popupMenu
    }
    
    //  Wifi
    func stopWifi() {
        var error: NSError?
        let iN = CWWiFiClient.sharedWiFiClient().interface().interfaceName
        let wifi = CWWiFiClient.sharedWiFiClient().interfaceWithName(iN)
        let result = wifi.setPower(false, error: &error)
    }
    
    func startWifi() {
        var error: NSError?
        let iN = CWWiFiClient.sharedWiFiClient().interface().interfaceName
        let wifi = CWWiFiClient.sharedWiFiClient().interfaceWithName(iN)
        let result = wifi.setPower(true, error: &error)
    }

    //  MARK: - Actions
    @IBAction func onSelectTime(sender: AnyObject) {
        if self.timer == nil && !self.runningInfinitely {
            self.sliderView?.timeSlider.enabled = false
            self.popupMenu?.startMenuItem.title = "Cancel"
            println("Starting timer with: \(self.sliderView?.requestedMinutes) Minutes.")
            self.stopWifi()
            
            if self.sliderView?.requestedMinutes != -1 {
                self.startTimer()
            } else {
                self.runInfinitely()
            }
        } else {
            println("We gotta cancel!")
            self.cancelTimer()
            self.runningInfinitely = false
        }
    }

    func startTimer() {
        //  Every 60 seconds
        self.timer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: "checkTimer", userInfo: nil, repeats: true)
    }
    
    func checkTimer() {
        self.sliderView?.minutesRemaining--
        println("Time remaining: \(self.sliderView?.minutesRemaining)")
        self.sliderView?.updateTimerText()
        if self.sliderView?.minutesRemaining <= 0 {
            self.cancelTimer()
            println("Done!")
        }
    }
    
    func runInfinitely() {
        println("Running infinitely")
        self.runningInfinitely = true
    }
    
    func cancelTimer() {
        println("Canceling timer")
        self.timer?.invalidate()
        self.timer = nil
        self.sliderView?.timeSlider.enabled = true
        self.popupMenu?.startMenuItem.enabled = true
        self.startWifi()
        self.popupMenu?.startMenuItem.title = "Start"
    }
}