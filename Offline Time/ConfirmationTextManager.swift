//
//  ConfirmationTextManager.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Foundation

class ConfirmationTextManager {
    let resources = NSBundle.mainBundle()
    var counter = 1
    var texts = NSMutableDictionary()
    
    init() {
        self.getTexts()
    }
    
    func getTexts() {
        let plist = self.resources.pathForResource("ConfirmationText", ofType: "plist")
        self.texts = NSMutableDictionary(contentsOfFile: plist!)!
    }
    
    func getTextForCurrentCounter() -> String {
        return self.texts["Text\(self.counter)"] as! String
    }
}