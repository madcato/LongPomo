//
//  Settings.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

class Settings {
    static var kPomodoInSeconds: String = "kPomodoInSeconds"
    static var kRestingInSeconds: String = "kRestingInSeconds"
    static var pomodoroInSeconds: Double = {
        let seconds = SimplePersistence.double(forKey: kPomodoInSeconds)
        if seconds != 0 {
            return seconds
        } else {
            return 90.minutes()  // 90 minutes
        }
    }() {
        didSet {
            SimplePersistence.store(pomodoroInSeconds, forKey: kPomodoInSeconds)
        }
    }

    static var restingInSeconds: Double = {
        let seconds = SimplePersistence.double(forKey: kRestingInSeconds)
        if seconds != 0 {
            return seconds
        } else {
            return 20.minutes()  // 20 minutes
        }
        }() {
        didSet {
            SimplePersistence.store(pomodoroInSeconds, forKey: kRestingInSeconds)
        }
    }
}
