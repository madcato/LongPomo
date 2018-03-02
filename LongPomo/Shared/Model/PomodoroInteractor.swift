//
//  PomodoroInteractor.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

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

    init(maxSeconds: Double) {
        self.maxSeconds = maxSeconds
        self.startTime = Date()
        self.timer = Timer()
    }

    func start(from date: Date) {
        startTime = date
        timer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                     repeats: true,
                                     block: { (_) in
            let now = Date()
            let differenceInSeconds = now.timeIntervalSince(self.startTime)
            let secondsLeft = self.maxSeconds - differenceInSeconds
            self.delegate?.timeChanged(secondsLeft: secondsLeft)
        })
        timer.fire()
    }

    func stop() {
        self.timer.invalidate()
    }
}
