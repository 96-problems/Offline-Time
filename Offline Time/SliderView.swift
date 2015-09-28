//
//  SliderView.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa

class SliderView: NSView {

    @IBOutlet var timeSlider: NSSlider!
    @IBOutlet var remainingLabel: NSTextField!
    
    var requestedMinutes = 10
    var minutesRemaining = 10
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    @IBAction func timeChanged(sender: NSSlider) {
        self.requestedMinutes = self.calculatedMinutes(sender.integerValue)
        println("Requested minutes: \(self.requestedMinutes)")
        self.minutesRemaining = self.requestedMinutes
        self.remainingLabel.stringValue = "Timer: \(self.convertMinutesIntoRegularFormat(self.requestedMinutes))"
    }
    
    func confirmSelectedTime() {
        self.requestedMinutes = self.calculatedMinutes(self.timeSlider.integerValue)
        self.minutesRemaining = self.requestedMinutes
    }
    
    func calculatedMinutes(sliderValue: Int) -> Int {
//        return 1
        if sliderValue < 7 {
            return sliderValue * 10
        } else if sliderValue == 7 {
            return 90
        } else if sliderValue == 8 {
            return 120
        } else if sliderValue == 9 {
            return 180
        } else if sliderValue == 10 {
            return 240
        } else if sliderValue == 11 {
            return 300
        } else if sliderValue == 12 {
            return 360
        } else if sliderValue == 13 {
            return 420
        } else if sliderValue == 14 {
            return 480
        } else if sliderValue == 15 {
            return 540
        } else if sliderValue == 16 {
            return 600
        } else if sliderValue == 17 {
            return 660
        } else if sliderValue == 18 {
            return 720
        } else if sliderValue == 19 {
            return 780
        } else if sliderValue == 20 {
            return 840
        } else if sliderValue == 21 {
            return 900
        } else if sliderValue == 22 {
            return 960
        } else if sliderValue == 23 {
            return 1020
        } else if sliderValue == 24 {
            return 1080
        } else if sliderValue == 25 {
            return 1140
        } else if sliderValue == 26 {
            return 1200
        } else if sliderValue == 27 {
            return 1260
        } else if sliderValue == 28 {
            return 1320
        } else if sliderValue == 29 {
            return 1380
        } else if sliderValue == 30 {
            return 1440
        } else if sliderValue == 31 {
            return -1
        } else {
            return 0
        }
    }
    
    func convertMinutesIntoRegularFormat(minutes: Int) -> String {
        if minutes < 60 && minutes != -1 {
            return "\(minutes) Minutes"
        } else if minutes == 60 {
            return "1 Hour"
        } else if minutes == 90 {
            return "1 Hour And 30 Minutes"
        } else if minutes == -1 {
            return "∞"
        } else {
            return "\(minutes/60) Hours"
        }
    }
    
    func updateTimerText() {
        self.remainingLabel.stringValue = "Currently Remaining: \(self.convertMinutesIntoRegularFormat(self.minutesRemaining))"
        if self.requestedMinutes == -1 {
            self.remainingLabel.stringValue = "Running Infinitely."
        }
        
        let forHours = self.minutesRemaining * 60 / 3600,
            remainder = self.minutesRemaining * 60 % 3600,
            forMinutes = remainder / 60,
            forSeconds = remainder % 60
        
        
    }
    
    func updateSlider() {
//        let currentTimeLeftInSeconds = NSTimeInterval(self.minutesRemaining * 60)
//        println(currentTimeLeftInSeconds)
//        let date = NSDate(timeIntervalSince1970: currentTimeLeftInSeconds)
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "HH:mm:ss"
//        let formatted = formatter.stringFromDate(date)
//        println(formatted)
    }
}
