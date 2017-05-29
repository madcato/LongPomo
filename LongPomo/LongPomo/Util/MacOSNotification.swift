//
//  MAcOSNotification.swift
//  LongPomo
//
//  Created by Daniel Vela on 28/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

class MacOSNotification {
    static func show(informativeText: String, title: String) {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = informativeText
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
}
