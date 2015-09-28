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
    
    var selectedValue = 10
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    @IBAction func timeChanged(sender: NSSlider) {
        println("Changing time?")
        println(sender.integerValue)
        self.remainingLabel.stringValue = "Currently Selected: \(self.convertMinutesIntoRegularFormat(self.calculatedMinutes(sender.integerValue)))"
    }
    
    func calculatedMinutes(sliderValue: Int) -> Int {
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
        if minutes < 60 {
            return "\(minutes) Minutes"
        } else if minutes == 60 {
            return "1 Hour"
        } else if minutes == 90 {
            return "1 Hour And 30 Minutes"
        } else {
            return "\(minutes/60) Hours"
        }
        return ""
    }
}