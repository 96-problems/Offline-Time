//
//  TweetView.swift
//  Offline Time
//
//  Created by Naoto Ida on 10/21/15.
//  Copyright © 2015 96Problems. All rights reserved.
//

import Cocoa

class TweetView: NSView {
    
    let localStore = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var button: NSButton!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    @IBAction func onToggleCheck(sender: AnyObject) {
        Swift.print(self.button.state)
        self.localStore.setBool(self.button.state.toBool()!, forKey: "SHOULD_PROMPT_TWEET")
    }
}

extension Int {
    func toBool () -> Bool? {
        switch self {
            case 0:
                return false
            case 1:
                return true
            default:
                return nil
        }
        
    }
}