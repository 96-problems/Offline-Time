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
    var requestedSeconds = 600
    var secondsRemaining = 600
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    func resetTimes() {
        self.requestedMinutes = 10
        self.minutesRemaining = 10
        self.requestedSeconds = self.requestedMinutes * 60
        self.secondsRemaining = self.minutesRemaining * 60
    }
    
    @IBAction func timeChanged(sender: NSSlider) {
        self.requestedMinutes = self.calculatedMinutes(sender.integerValue)
        self.requestedSeconds = self.requestedMinutes * 60
        Swift.print("Requested minutes: \(self.requestedMinutes)")
        Swift.print("Requested seconds: \(self.requestedSeconds)")
        self.minutesRemaining = self.requestedMinutes
        self.secondsRemaining = self.requestedSeconds
        
        self.convertSecondsToHHMMSS(self.requestedSeconds)
        self.remainingLabel.stringValue = "Timer: \(self.convertMinutesIntoRegularFormat(self.requestedMinutes))"
    }
    
    func confirmSelectedTime() {
        self.requestedMinutes = self.calculatedMinutes(self.timeSlider.integerValue)
        self.minutesRemaining = self.requestedMinutes
    }
    
    func calculatedSeconds(sliderValue: Int) -> Int {
        //        return 1
        if sliderValue < 7 {
            return sliderValue * 10
        } else if sliderValue == 7 {
            return 90 * 60
        } else if sliderValue == 8 {
            return 120 * 60
        } else if sliderValue == 9 {
            return 180 * 60
        } else if sliderValue == 10 {
            return 240 * 60
        } else if sliderValue == 11 {
            return 300 * 60
        } else if sliderValue == 12 {
            return 360 * 60
        } else if sliderValue == 13 {
            return 420 * 60
        } else if sliderValue == 14 {
            return 480 * 60
        } else if sliderValue == 15 {
            return 540 * 60
        } else if sliderValue == 16 {
            return 600 * 60
        } else if sliderValue == 17 {
            return 660 * 60
        } else if sliderValue == 18 {
            return 720 * 60
        } else if sliderValue == 19 {
            return 780 * 60
        } else if sliderValue == 20 {
            return 840 * 60
        } else if sliderValue == 21 {
            return 900 * 60
        } else if sliderValue == 22 {
            return 960 * 60
        } else if sliderValue == 23 {
            return 1020 * 60
        } else if sliderValue == 24 {
            return 1080 * 60
        } else if sliderValue == 25 {
            return 1140 * 60
        } else if sliderValue == 26 {
            return 1200 * 60
        } else if sliderValue == 27 {
            return 1260 * 60
        } else if sliderValue == 28 {
            return 1320 * 60
        } else if sliderValue == 29 {
            return 1380 * 60
        } else if sliderValue == 30 {
            return 1440 * 60
        } else if sliderValue == 31 {
            return -1
        } else {
            return 0
        }
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
//        self.remainingLabel.stringValue = "Currently Remaining: \(self.convertMinutesIntoRegularFormat(self.minutesRemaining))"
//        if self.requestedMinutes == -1 {
//            self.remainingLabel.stringValue = "Running Infinitely."
//        }
        self.remainingLabel.stringValue = self.convertSecondsToHHMMSS(self.secondsRemaining)
        self.remainingLabel.needsDisplay = true
    }
    
    func convertSecondsToHHMMSS(seconds: Int) -> String {
        var hhmmss = ""
        var hours = String(seconds / 3600),
            remainder = seconds % 3600,
            minutes = String(remainder / 60),
            seconds = String(remainder % 60)
        
        if hours == "0" {
            hours = "00"
        } else {
            if (hours as NSString).length == 1 {
                hours = "0" + hours
            }
        }
        if minutes == "0" {
            minutes = "00"
        } else {
            if (minutes as NSString).length == 1 {
                minutes = "0" + minutes
            }
        }
        if seconds == "0" {
            seconds = "00"
        } else {
            if (seconds as NSString).length == 1  {
                seconds = "0" + seconds
            }
        }
        
        if hours == "00" && minutes == "00" {
            hhmmss = "00:00:\(String(seconds)) and Counting..."
        } else if hours == "00" && minutes != "00" {
            hhmmss = "00:\(String(minutes)):\(String(seconds)) and Counting..."
        } else {
            hhmmss = "\(String(hours)):\(String(minutes)):\(String(seconds)) and Counting..."
        }
        return hhmmss
    }
    
    func updateSlider() {
    }
}
