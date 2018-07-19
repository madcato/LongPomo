//
//  RestorationManager.swift
//  LongPomo
//
//  Created by Daniel Vela Angulo on 19/07/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import Foundation

class RestorationManager {
    static func appActivated() {
        let interactor = PomodoroInteractor.shared
        interactor.startTime = Settings.startingDate
        if let startingTime = interactor.startTime {
            // Calculate the current state of the times
            let now = Date()
            let interval = now.timeIntervalSince(startingTime)
            let fullPeriod = Settings.pomodoroInSeconds + Settings.restingInSeconds
            if interval < Settings.pomodoroInSeconds {
                // Pomodoro currently
                interactor.secondsLeft = Settings.pomodoroInSeconds - interval
                interactor.maxSeconds = Settings.pomodoroInSeconds
                interactor.start(from: startingTime)
                interactor.initialState = .onGoing
            } else if interval < fullPeriod {
                // Resting  currently
                interactor.secondsLeft = fullPeriod - interval
                interactor.maxSeconds = Settings.restingInSeconds
                interactor.start(from: startingTime)
                interactor.initialState = .resting
            } else {
                // App stopped
                interactor.startTime = nil
                interactor.maxSeconds = Settings.pomodoroInSeconds
                interactor.initialState = .stopped
            }
        }
    }

    static func appDeactivated() {
        let interactor = PomodoroInteractor.shared
        Settings.startingDate = interactor.startTime
        interactor.stop() // We don't need the timer to run on background.
    }
}
