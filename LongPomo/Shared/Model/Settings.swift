//
//  Settings.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

class Settings {
    private static var kPomodoInSeconds: String = "kPomodoInSeconds"
    private static var kRestingInSeconds: String = "kRestingInSeconds"
    static var pomodoroInSeconds: Double = {
        return storedDouble(forKey: kPomodoInSeconds, default: 90)
    }() {
        didSet {
            SimplePersistence.store(pomodoroInSeconds, forKey: kPomodoInSeconds)
        }
    }

    static var restingInSeconds: Double = {
        return storedDouble(forKey: kRestingInSeconds, default: 20)
    }() {
        didSet {
            SimplePersistence.store(restingInSeconds, forKey: kRestingInSeconds)
        }
    }

    private static func storedDouble(forKey key: String,
                                     default defaultValue: Double) -> Double {
        let seconds = SimplePersistence.double(forKey: key)
        if seconds != 0 {
            return seconds
        } else {
            return defaultValue.minutes()  // 90 minutes
        }
    }
}
