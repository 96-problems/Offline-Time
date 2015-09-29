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
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var mainBundle = NSBundle.mainBundle()
    var helperBundle: NSBundle!
    
    var statusItem: NSStatusItem?
    var sliderView: SliderView?
    var popupMenu: PopupMenu?
    
    var menuViewController: NSViewController?
    var timer: NSTimer?
    var runningInfinitely = false
    var confTextManager: ConfirmationTextManager?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
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
            button.image?.setTemplate(true)
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
        (self.popupMenu!.startAtLoginMenuItem.view as! SALView).customDelegate = self.popupMenu
        let shouldStartOnStartup = PALoginItemUtility.isCurrentApplicatonInLoginItems()
        if shouldStartOnStartup {
            salView.button.integerValue = 1
        }
        
        //  Start button
        let startButtonMenuItem = NSMenuItem(title: "Start", action: "onSelectTime:", keyEquivalent: "")
        self.popupMenu?.startMenuItem = startButtonMenuItem
        self.popupMenu?.insertItem(self.popupMenu!.startMenuItem, atIndex: 0)
        
        self.statusItem?.menu = self.popupMenu

        self.popupMenu?.customDelegate = self
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
            println("Starting timer with: \(self.sliderView?.requestedMinutes) Minutes.")
            self.stopWifi()
            self.popupMenu?.itemAtIndex(3)?.enabled = false
            if self.sliderView?.requestedMinutes != -1 {
                self.sliderView?.confirmSelectedTime()
                self.startTimer()
            } else {
                self.runInfinitely()
            }
        } else {
            if self.confTextManager != nil {
                self.confTextManager?.counter++
                if self.confTextManager!.texts.count + 1 > self.confTextManager!.counter {
                    self.popupMenu?.startMenuItem.title = self.confTextManager!.getTextForCurrentCounter()
                } else {
                    self.cancelTimer()
                    self.showNotificationOnTimerCompletion(self.sliderView!.requestedMinutes)
                    self.runningInfinitely = false
                }
            }
        }
    }

    func startTimer() {
        if self.confTextManager == nil {
            self.confTextManager = ConfirmationTextManager()
        }
        self.popupMenu?.quitMenuItem.hidden = true
        self.popupMenu?.startMenuItem.title = self.confTextManager!.getTextForCurrentCounter()
        self.sliderView?.updateSlider()
        //  Check every 60 seconds
        self.timer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: "checkTimer", userInfo: nil, repeats: true)
    }
    
    func checkTimer() {
        self.sliderView?.minutesRemaining--
        println("Time remaining: \(self.sliderView?.minutesRemaining)")
        self.sliderView?.updateTimerText()
        self.sliderView?.updateSlider()
        if self.sliderView?.minutesRemaining <= 0 {
            self.cancelTimer()
            println("Done!")
        }
    }
    
    func runInfinitely() {
        println("Running infinitely")
        if self.confTextManager == nil {
            self.confTextManager = ConfirmationTextManager()
        }
        self.runningInfinitely = true
    }
    
    func cancelTimer() {
        println("Canceling timer")
        self.popupMenu?.quitMenuItem.hidden = false
        self.timer?.invalidate()
        self.timer = nil
        self.confTextManager?.counter = 1
        self.sliderView?.timeSlider.enabled = true
        self.popupMenu?.startMenuItem.enabled = true
        self.startWifi()
        self.popupMenu?.startMenuItem.title = "Start"
    }
    
    func showNotificationOnTimerCompletion(duration: Int) {
        let durationText = self.sliderView!.convertMinutesIntoRegularFormat(duration)
        
        println("Sending notification")
        let notification = NSUserNotification()
        notification.title = "Offline Time"
//        notification.subtitle = "Foo"
        notification.informativeText = "Wow! You've been offline for \(durationText)."
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
}

extension AppDelegate: PopupMenuDelegate {
    func onToggleStartup(state: Int) {
        if state == 1 {
            PALoginItemUtility.addCurrentApplicatonToLoginItems()
        } else {
            PALoginItemUtility.removeCurrentApplicatonToLoginItems()
        }
    }
    
    func onRequestQuit() {
        NSApplication.sharedApplication().terminate(self)
    }
}

extension AppDelegate: NSUserNotificationCenterDelegate {
    func userNotificationCenter(center: NSUserNotificationCenter, didActivateNotification notification: NSUserNotification) {
    }
    
    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }
}