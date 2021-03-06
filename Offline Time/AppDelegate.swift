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
    let defaults = NSUserDefaults.standardUserDefaults()
    let mainBundle = NSBundle.mainBundle()
    var helperBundle: NSBundle!
    let constants = AppConstantsManager.sharedInstance
    let appName = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleNameKey as String) as! String
    
    var statusItem: NSStatusItem?
    var sliderView: SliderView?
    var popupMenu: PopupMenu?
    
    var menuViewController: NSViewController?
    var timer: NSTimer?
    var secondsTimer: NSTimer?
    var runningInfinitely = false
    var confTextManager: ConfirmationTextManager?
    var wifiIconIsHidden = false

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
            button.image?.template = true
        }
        
        //  Get menu
        var views: NSArray?
        NSBundle.mainBundle().loadNibNamed("PopupMenu", owner: self, topLevelObjects: &views)
        var menu: PopupMenu!
        for view in views! {
            if view.isMemberOfClass(PopupMenu) {
                menu = view as! PopupMenu
            }
        }
        self.popupMenu = menu
        
        //  Get sliderView
        var views2: NSArray?
        NSBundle.mainBundle().loadNibNamed("SliderViewController", owner: self, topLevelObjects: &views2)
        for view in views2! {
            if view.isMemberOfClass(SliderView) {
                self.sliderView = view as? SliderView
            }
        }
        self.popupMenu!.sliderMenuItem.view = sliderView
        
        
        //  Start at Login
        var salView: SALView!
        var views3: NSArray?
        NSBundle.mainBundle().loadNibNamed("SALViewController", owner: self, topLevelObjects: &views3)
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
        
        
        //  Tweet
        var tweetView: TweetView!
        var views4: NSArray?
        NSBundle.mainBundle().loadNibNamed("TweetViewController", owner: self, topLevelObjects: &views4)
        for view in views4! {
            if view.isMemberOfClass(TweetView) {
                tweetView = view as! TweetView
            }
        }
        self.popupMenu!.toggleTweetMenuItem.view = tweetView
        if self.defaults.boolForKey("SHOULD_PROMPT_TWEET") {
            (self.popupMenu!.toggleTweetMenuItem.view as! TweetView).button.integerValue = 1
        } else {
            if !self.defaults.boolForKey("LAUNCHED_PREVIOUSLY") {
                self.defaults.setBool(true, forKey: "LAUNCHED_PREVIOUSLY")
                (self.popupMenu!.toggleTweetMenuItem.view as! TweetView).button.integerValue = 1
            } else {
                (self.popupMenu!.toggleTweetMenuItem.view as! TweetView).button.integerValue = 0
            }
        }
        
        
        //  Start button
        let startButtonMenuItem = NSMenuItem(title: "Start Offline Time", action: "onSelectTime:", keyEquivalent: "")
        self.popupMenu?.startMenuItem = startButtonMenuItem
        self.popupMenu?.insertItem(self.popupMenu!.startMenuItem, atIndex: 0)
        
        self.statusItem?.menu = self.popupMenu

        self.popupMenu?.customDelegate = self
    }
    
    //  Wifi
    func hideWifiIcon() {
//
//        println("Hiding wifi icon")
//        let systemUIServer = self.defaults.persistentDomainForName("com.apple.systemuiserver") as! [String: AnyObject]
//        var menuItems = systemUIServer["menuExtras"] as! [String]
//        var wasActuallyAtZero = false
//        var i = 0
//        var wifiPos = 0
//        for menuItem in menuItems {
//            if menuItem == "/System/Library/CoreServices/Menu Extras/AirPort.menu" && i != 0 {
//                println("Wi-fi icon is shown at index \(i)")
//                wifiPos = i
//            } else if menuItem == "/System/Library/CoreServices/Menu Extras/AirPort.menu" && i == 0 {
//                println("Wi-fi icon is hown at index 0")
//                wifiPos = 0
//                wasActuallyAtZero = true
//            }
//            i++
//        }
//        if wifiPos != 0 || (wifiPos == 0 && wasActuallyAtZero) {
//            menuItems.removeAtIndex(wifiPos)
//            self.wifiIconIsHidden = true
//            var newSystemUIServer: NSMutableDictionary = NSMutableDictionary(dictionary: systemUIServer)
//            newSystemUIServer.setValue(menuItems, forKey: "menuExtras")
//            self.defaults.setPersistentDomain(newSystemUIServer as [NSObject : AnyObject], forName: "com.apple.systemuiserver")
//            
//            //  Run shell command to restart SystemUIServer
//            let task = NSTask()
//            task.launchPath = "/bin/bash"
//            task.arguments = ["-c", "killall SystemUIServer -HUP"]
//            task.launch()
//        } else {
//            println("No need to hide it because it already is")
//        }
    }
    
    func showWifiIcon() {
//        println("Showing wifi icon")
//        let systemUIServer = self.defaults.persistentDomainForName("com.apple.systemuiserver") as! [String: AnyObject]
//        var menuItems = systemUIServer["menuExtras"] as! [String]
//        println(menuItems)
//        var wifiIconIsAlreadyShown = false
//        for menuItem in menuItems {
//            if menuItem == "/System/Library/CoreServices/Menu Extras/AirPort.menu" {
//                wifiIconIsAlreadyShown = true
//            }
//        }
//        
//        if !wifiIconIsAlreadyShown {
//            //  Run shell command to show wifi icon
//            let task = NSTask()
//            task.launchPath = "/bin/bash"
//            task.arguments = ["-c", "defaults write com.apple.systemuiserver menuExtras -array-add '/System/Library/CoreServices/Menu Extras/Airport.menu'"]
//            task.launch()
//            
//            let task2 = NSTask()
//            task2.launchPath = "/bin/bash"
//            task2.arguments = ["-c", "killall SystemUIServer -HUP"]
//            task2.launch()
//        }
//        self.wifiIconIsHidden = false
    }
    
    func stopWifi() {
//        if let button = self.statusItem!.button {
//            button.image = NSImage(named: "StatusBarButtonImage2")
//            button.image?.setTemplate(true)
//        }
        let iN = CWWiFiClient.sharedWiFiClient().interface()!.interfaceName
        let wifi = CWWiFiClient.sharedWiFiClient().interfaceWithName(iN)
        do {
            try wifi!.setPower(false)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func startWifi() {
//        if let button = self.statusItem!.button {
//            button.image = NSImage(named: "StatusBarButtonImage")
//            button.image?.setTemplate(true)
//        }
        let iN = CWWiFiClient.sharedWiFiClient().interface()!.interfaceName
        let wifi = CWWiFiClient.sharedWiFiClient().interfaceWithName(iN)
        do {
            try wifi!.setPower(true)
        } catch let error as NSError {
            print(error)
        }
    }

    //  MARK: - Actions
    @IBAction func onSelectTime(sender: AnyObject) {
        if self.timer == nil && !self.runningInfinitely {
            self.sliderView?.timeSlider.enabled = false
            self.hideWifiIcon()
            print("Starting timer with: \(self.sliderView?.requestedMinutes) Minutes.")
//            #if RELEASE
                self.stopWifi()
//            #endif
//            self.popupMenu?.itemAtIndex(3)?.enabled = false
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
                    self.cancelTimer(shouldCongradulate: false)
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
        NSRunLoop.currentRunLoop().addTimer(self.timer!, forMode: NSDefaultRunLoopMode)
        NSRunLoop.currentRunLoop().addTimer(self.timer!, forMode: NSEventTrackingRunLoopMode)
        
        //  Check every 1 second
        self.secondsTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "checkTimerEverySecond", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.secondsTimer!, forMode: NSDefaultRunLoopMode)
        NSRunLoop.currentRunLoop().addTimer(self.secondsTimer!, forMode: NSEventTrackingRunLoopMode)
    }
    
    func checkTimer() {
        self.sliderView?.minutesRemaining--
        print("Time remaining: \(self.sliderView?.minutesRemaining) Minutes.")
        
        self.sliderView?.updateSlider()
        
        if self.sliderView?.minutesRemaining <= 0 {
            self.cancelTimer(shouldCongradulate: true)
            print("Done!")
        }
    }
    
    func checkTimerEverySecond() {
        self.sliderView?.secondsRemaining--
        self.sliderView?.updateTimerText()
        
        guard self.sliderView!.secondsRemaining + 5 < self.sliderView?.requestedSeconds else {
            return
        }
        if Reachability.isConnectedToNetwork() {
            //  No ....
            //self.cancelTimer(shouldCongradulate: false)
            self.forceContinuationOfTimer()
        } else {
            //  Keep it up!
        }
    }
    
    func forceContinuationOfTimer() {
        self.stopWifi()
        self.showNotificationOnQuitAttempt()
    }
    
    func runInfinitely() {
        print("Running infinitely")
        if self.confTextManager == nil {
            self.confTextManager = ConfirmationTextManager()
        }
        self.runningInfinitely = true
        self.popupMenu?.quitMenuItem.hidden = true
        self.popupMenu?.startMenuItem.title = self.confTextManager!.getTextForCurrentCounter()
        self.sliderView?.remainingLabel.stringValue = "Running Infinitely"
    }
    
    func cancelTimer(shouldCongradulate shouldCongradulate: Bool) {
        print("Canceling timer")
        self.popupMenu?.quitMenuItem.hidden = false
        self.timer?.invalidate()
        self.timer = nil
        self.secondsTimer?.invalidate()
        self.secondsTimer = nil
        self.sliderView?.timeSlider.enabled = true
        self.popupMenu?.startMenuItem.enabled = true
//        #if RELEASE
            self.startWifi()
//        #endif
        self.popupMenu?.startMenuItem.title = "Start \(self.appName)"

        if shouldCongradulate {
            self.showNotificationOnTimerCompletion()
        } else if !shouldCongradulate && (self.confTextManager?.counter == self.confTextManager!.texts.count + 1) {
        } else {
            self.showNotificationOnWifiOn()
        }
        self.sliderView?.remainingLabel.stringValue = "\(self.appName): 10 Minutes"
        self.sliderView?.timeSlider.integerValue = 1
        self.confTextManager?.counter = 1
        self.sliderView?.resetTimes()
        self.confTextManager = nil
    }
    
    func showNotificationOnTimerCompletion() {
        self.notify(self.constants.value("CONGRATULATION_MSG") as! String)
        self.promptForTweet()
    }
    
    func showNotificationOnWifiOn() {
        self.notify(self.constants.value("TOO_BAD_MSG") as! String)
    }
    
    func showNotificationOnQuitAttempt() {
        self.notify(self.constants.value("DENY_MSG") as! String)
    }
    
    func notify(text: String) {
        let notification = NSUserNotification()
        notification.title = self.appName
        notification.informativeText = text.replaceCustomTagWithRequestedMinutes(self.sliderView!.convertMinutesIntoRegularFormat(self.sliderView!.requestedMinutes))
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
    
    func promptForTweet() {
        if self.defaults.boolForKey("SHOULD_PROMPT_TWEET") {
            
            //  Just in case someone completes infinite...
            guard self.sliderView!.requestedMinutes > 0 else { return }
            
            let alert = NSAlert()
            let askMsg = self.constants.value("SuggestTweetMsg") as? NSString
            alert.messageText = askMsg!.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
            alert.addButtonWithTitle("Tweet")
            alert.addButtonWithTitle("Cancel")
            switch alert.runModal() {
                case NSAlertFirstButtonReturn:
                    let rawTweetURL = self.constants.value("TweetURL") as! String,
                        tweetURL = rawTweetURL.replaceCustomTagWithRequestedMinutes("\(self.sliderView!.requestedMinutes)min"),
//                        tweetURLstr = tweetURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                        tweetURLstr = tweetURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                    
                    NSWorkspace.sharedWorkspace().openURL(NSURL(string: tweetURLstr!)!)
                    break
                default:
                    break
            }
        }
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

extension String {
    func replaceCustomTagWithRequestedMinutes(minutes: String) -> String {
        return stringByReplacingOccurrencesOfString("{{ minutes }}", withString: "\(minutes)")
    }
}