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

    static func resetNotifications() {
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
        IosNotification.show(informativeText: informativeText, title: title)
    }

    /**
     Called when the user starts the process
     */
    static func start() {
    }

     static func resetNotifications() {
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
            setATimerNotification(1, message: "Resting finished")
        } else {
            WKInterfaceDevice.current().play(.success)
            WKInterfaceDevice.current().play(.success)
            setATimerNotification(1, message: "Finished")
        }
    }

    /**
        Called when the user starts the process
    */
    static func start() {
    }
    
    static func setATimerNotification(_ seconds: Double, message: String) {
        #if os(watchOS)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "LongPomo"
        content.body = message
        content.sound = UNNotificationSound.default()
        // Create the trigger as a repeating event.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: seconds, repeats: false)
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error notification: \(error)")
            }
        }
        #endif
    }

    static func resetNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
#endif
