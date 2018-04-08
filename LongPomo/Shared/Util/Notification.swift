//
//  Notification.swift
//  LongPomo
//
//  Created by Daniel Vela on 24/02/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

#if os(macOS)
/**
     Class to show notifications in multiple platforms
*/
class LPNotification {
    /**
     Present a notification in the macOS desktop immediately
     - Parameter informativeText: Text to present
     - Parameter title: Title of the notification
    */
    static func show(informativeText: String, title: String) {
        MacOSNotification.show(informativeText: informativeText, title: title)
    }
}
#endif

#if os(iOS)
    /**
     Class to show notifications in multiple platforms
     */
class LPNotification {
    /**
     Present a notification in the macOS desktop immediately
     - Parameter informativeText: Text to present
     - Parameter title: Title of the notification
     */
    static func show(informativeText: String, title: String) {
        IosNotification.show(informativeText: informativeText, title: title)
    }
}
#endif

#if os(watchOS)
import WatchKit
/**
 Class to show notifications in multiple platforms
 */
class LPNotification {
    /**
     Present a notification in the macOS desktop immediately
     - Parameter informativeText: Text to present
     - Parameter title: Title of the notification
     */
    static func show(informativeText: String, title: String) {
        WKInterfaceDevice.current().play(.success)
    }
}
#endif
