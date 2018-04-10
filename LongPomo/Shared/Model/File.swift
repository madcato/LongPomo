//
//  File.swift
//  LongPomo
//
//  Created by Daniel Vela on 10/04/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import UserNotifications

class LongPomoNotificationManager {
    static var shared = LongPomoNotificationManager()

    func askPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (_, _) in
            // Enable or disable features based on authorization
        }
    }

    func appActivated() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

    }

    func appDeactivated() {
    }

    /**
     Present one or two notification: one for time finish, other for rest finish
     - Parameter time number of seconds to show a finish time notification
     - Parameter restTime number of seconds to show the rest time finish notification
    */
    func scheduleNotifications(for time: Double?, andfor restTime: Double) {
        if let time = time {
            scheduleNotification(for: time, message: "Finished")
        }
        scheduleNotification(for: restTime, message: "Rest finished")
    }

    func scheduleNotification(for time: Double, message: String) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey:
            "LongPomo", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey:
            message, arguments: nil)

        // Deliver the notification in five seconds.
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time,
                                                        repeats: false)

        // Schedule the notification.
        let request = UNNotificationRequest(identifier: message,
                                            content: content,
                                            trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
}
