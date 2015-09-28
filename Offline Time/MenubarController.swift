//
//  MenubarController.swift
//  Offline Time
//
//  Created by Naoto Ida on 9/28/15.
//  Copyright (c) 2015 96Problems. All rights reserved.
//

import Cocoa

class MenubarController: NSObject {
    let STATUS_ITEM_VIEW_WIDTH: CGFloat = 2.40
    
    override init() {
        let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(STATUS_ITEM_VIEW_WIDTH)
    }
}
