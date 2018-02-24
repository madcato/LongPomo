//
//  AppDelegate.swift
//  LongPomo
//
//  Created by Daniel Vela on 18/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        configureMainAppearance()
    }

    public func applicationWillTerminate(_ aNotification: Notification) {
    }

    func configureMainAppearance() {
        let window = NSApplication.shared.mainWindow
        window?.titlebarAppearsTransparent = true
        window?.backgroundColor = AppColors.backgroundColor
    }
}
