//
//  SettingsLocal.swift
//  LongPomo
//
//  Created by Daniel Vela on 01/03/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import Foundation

class SettingsLocal: SettingsProtocol {
    private static var kPomodoInSeconds: String = "kPomodoInSeconds"
    private static var kRestingInSeconds: String = "kRestingInSeconds"
    var pomodoroInSeconds: Double = {
        return storedDouble(forKey: SettingsLocal.kPomodoInSeconds, default: 90)
        }() {
        didSet {
            SimplePersistence.store(pomodoroInSeconds, forKey: SettingsLocal.kPomodoInSeconds)
        }
    }

    var restingInSeconds: Double = {
        return storedDouble(forKey: kRestingInSeconds, default: 20)
        }() {
        didSet {
            SimplePersistence.store(restingInSeconds, forKey: SettingsLocal.kRestingInSeconds)
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

//extension Settings {
//    static func initializeLocal() {
//        Settings.settingsProvider = SettingsLocal()
//    }
//}
