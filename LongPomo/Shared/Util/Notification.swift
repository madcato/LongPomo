//
//  Notification.swift
//  LongPomo
//
//  Created by Daniel Vela on 24/02/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

#if os(macOS)
    class Notification {
        static func show(informativeText: String, title: String) {
            MacOSNotification.show(informativeText: informativeText, title: title)
        }
    }
#endif

#if os(iOS)
    class Notification {
        static func show(informativeText: String, title: String) {
            IosNotification.show(informativeText: informativeText, title: title)
        }
    }
#endif
