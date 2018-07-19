//
//  Settings.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

protocol SettingsProtocol {
    var pomodoroInSeconds: Double { get set }
    var restingInSeconds: Double { get set }
    var startingDate: Date? {get set }
}

class Settings {
    static var settingsProvider: SettingsProtocol! = {
        return SettingsLocal()
    }()

    static var pomodoroInSeconds: Double {
        get {
            return settingsProvider.pomodoroInSeconds
        }
        set {
            settingsProvider.pomodoroInSeconds = newValue
        }
    }

    static var restingInSeconds: Double {
        get {
            return settingsProvider.restingInSeconds
        }
        set {
            settingsProvider.restingInSeconds = newValue
        }
    }

    static var startingDate: Date? {
        get {
            return settingsProvider.startingDate
        }
        set {
            settingsProvider.startingDate = newValue
        }
    }
}
