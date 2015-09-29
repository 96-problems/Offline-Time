//
//  CustomSliderCell.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/29/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa

class CustomSliderCell: NSSliderCell {
    var activeColor = NSColor(calibratedRed: 236/255, green: 92/255, blue: 111/255, alpha: 1.0)
    var inactiveColor = NSColor(calibratedRed: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawKnob(knobRect: NSRect) {
        let image = NSImage(named: "SliderKnob")
        //  For some patterns
//        NSColor(patternImage: image!).set()
//        NSRectFill(NSMakeRect(knobRect.origin.x, knobRect.origin.y, 20, 20))
        let x = knobRect.origin.x + (knobRect.size.width - image!.size.width) / 2
        let y = NSMaxY(knobRect) - (knobRect.size.height - image!.size.height) / 2 - 18
        image?.drawAtPoint(NSMakePoint(x, y), fromRect: NSZeroRect, operation: NSCompositingOperation.CompositeSourceOver, fraction: 1.0)
    }
 
    
    override func drawBarInside(aRect: NSRect, flipped: Bool) {
        var rect = aRect
        rect.size.height = CGFloat(5)
        let barRadius = CGFloat(2.5)
        let value = CGFloat((self.doubleValue - self.minValue) / (self.maxValue - self.minValue))
        
        let finalWidth = CGFloat(value * (self.controlView!.frame.size.width - 8))
        var leftRect = rect
        leftRect.size.width = finalWidth
        let bg = NSBezierPath(roundedRect: rect, xRadius: barRadius, yRadius: barRadius)
        self.inactiveColor.setFill()
        bg.fill()
        let active = NSBezierPath(roundedRect: leftRect, xRadius: barRadius, yRadius: barRadius)
        self.activeColor.setFill()
        active.fill()
    }
    
    //  There are no ticks on me!
    override func rectOfTickMarkAtIndex(index: Int) -> NSRect {
        return NSZeroRect
    }
}
