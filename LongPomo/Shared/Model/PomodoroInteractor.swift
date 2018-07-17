//
//  PomodoroInteractor.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation
import UserNotifications

protocol PomodoroInteractorProtocol {
    /**
     Start the internal timer of the app.

     - Parameters:
        - date: The start time of the timer. This way, the app can start timers
                locally, started on other devices. Pass the start time of the
                other device timer to indicate how to calculate de current progrees.
     */
    func start(from date: Date)
    func stop()
    var maxSeconds: Double { get set }
    weak var delegate: PomodoroInteractorDelegate? { get set }
}

protocol PomodoroInteractorDelegate: class {
    func timeChanged(secondsLeft: Double)
}

class PomodoroInteractor: PomodoroInteractorProtocol {
    var maxSeconds: Double
    var startTime: Date
    var timer: Timer
    weak var delegate: PomodoroInteractorDelegate?
    var secondsLeft: Double {
        let now = Date()
        let differenceInSeconds = now.timeIntervalSince(self.startTime)
        return self.maxSeconds - differenceInSeconds
    }

    init(maxSeconds: Double) {
        self.maxSeconds = maxSeconds
        self.startTime = Date()
        self.timer = Timer()
    }

    func start(from date: Date) {
        startTime = date
//        setATimerNotification(secondsLeft)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                     repeats: true,
                                     block: { (_) in
            self.delegate?.timeChanged(secondsLeft: self.secondsLeft)
        })
        timer.fire()
    }

    func stop() {
        self.timer.invalidate()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

//    func setATimerNotification(_ seconds: Double) {
//#if os(watchOS)
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        let content = UNMutableNotificationContent()
//        content.title = "LongPomo"
//        content.body = "Finished"
//        content.sound = UNNotificationSound.default()
//        // Create the trigger as a repeating event.
//        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: seconds, repeats: false)
//        // Create the request
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString,
//                                            content: content,
//                                            trigger: trigger)
//        // Schedule the request with the system.
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.add(request) { (error) in
//            if let error = error {
//                print("Error notification: \(error)")
//            }
//        }
//#endif
//    }
}
