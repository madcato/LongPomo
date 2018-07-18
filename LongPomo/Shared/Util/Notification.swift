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
     - Parameter resting: true if the app state was resting, false otherwise
    */
    static func show(informativeText: String, title: String, resting: Bool) {
        MacOSNotification.show(informativeText: informativeText, title: title)
    }

    /**
     Called when the user starts the process
     */
    static func start() {
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
     - Parameter resting: true if the app state was resting, false otherwise
     */
    static func show(informativeText: String, title: String, resting: Bool) {
    }

    /**
     Called when the user starts the process
     */
    static func start() {
        let time = Settings.pomodoroInSeconds
        let restTime = time + Settings.restingInSeconds
        LongPomoNotificationManager.shared.scheduleNotifications(for: time, andfor: restTime)
    }
}
#endif

#if os(watchOS)
import WatchKit
import UserNotifications
/**
 Class to show notifications in multiple platforms
 */
class LPNotification {
    /**
     Present a notification in the macOS desktop immediately
     - Parameter informativeText: Text to present
     - Parameter title: Title of the notification
     - Parameter resting: true if the app state was resting, false otherwise

     https://developer.apple.com/documentation/watchkit/wkhaptictype
     */
    static func show(informativeText: String, title: String, resting: Bool) {
        if resting {
            WKInterfaceDevice.current().play(.stop)
            WKInterfaceDevice.current().play(.stop)
        } else {
            WKInterfaceDevice.current().play(.success)
            WKInterfaceDevice.current().play(.success)
        }
    }

    /**
        Called when the user starts the process
    */
    static func start() {
        let time = Settings.pomodoroInSeconds
        let restTime = time + Settings.restingInSeconds
        LongPomoNotificationManager.shared.scheduleNotifications(for: time, andfor: restTime)
    }
}
#endif
