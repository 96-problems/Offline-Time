//
//  AppConstantsManager.swift
//  First Draft
//
//  Created by Naoto Ida on 9/18/15.
//  Copyright (c) 2015 96 Problems. All rights reserved.
//

import Foundation

class AppConstantsManager {
    static let sharedInstance = AppConstantsManager()
    var constants = NSMutableDictionary()
    let plist = NSBundle.mainBundle().pathForResource("AppConstants", ofType: "plist")
    
    init() {
        self.constants = NSMutableDictionary(contentsOfFile: self.plist!)!
    }
    
    func value(key: String) -> AnyObject {
        return self.constants.valueForKey(key)!
    }
}