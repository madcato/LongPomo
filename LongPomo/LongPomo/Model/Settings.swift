//
//  Settings.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

class Settings {
    static var pomodoroInSeconds: Double = {
        return 0.1.minutes()  // 90 minutes
    }()
    static var restingInSeconds: Double = {
        return 0.05.minutes()  // 20 minutes
    }()
}
