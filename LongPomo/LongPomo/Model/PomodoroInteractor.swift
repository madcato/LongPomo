//
//  PomodoroInteractor.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

protocol PomodoroInteractorProtocol {
    func start()
    func stop()
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

    func start() {
        startTime = Date()
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
