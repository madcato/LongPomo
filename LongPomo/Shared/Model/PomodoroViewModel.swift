//
//  PomodoroViewModel.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

enum PomodoroState {
    case onGoing
    case resting
}

protocol PomodoroViewModelProtocol {
    var running: Bool { get }
    var runningDidChange: ((PomodoroViewModelProtocol) -> Void)? { get set }

    var secondsLeft: Double? { get }
    var sencondsLeftDidChange: ((PomodoroViewModelProtocol) -> Void)? { get set }

    var state: PomodoroState { get }
    var stateDidChange: ((PomodoroViewModelProtocol) -> Void)? { get set }

    func play()
    func stop()
    func reset()
    func currentProgress() -> Double

    init(interactor: PomodoroInteractorProtocol)
}

class PomodoroViewModel: PomodoroViewModelProtocol, PomodoroInteractorDelegate {
    var running: Bool {
        didSet {
            self.runningDidChange?(self)
        }
    }
    var runningDidChange: ((PomodoroViewModelProtocol) -> Void)?

    var secondsLeft: Double? {
        didSet {
            self.sencondsLeftDidChange?(self)
        }
    }
    var sencondsLeftDidChange: ((PomodoroViewModelProtocol) -> Void)?

    var state: PomodoroState {
        didSet {
            self.stateDidChange?(self)
        }
    }
    var stateDidChange: ((PomodoroViewModelProtocol) -> Void)?

    var interactor: PomodoroInteractorProtocol

    func play() {
        assert(running == false, "Play can't be called, if app counter is running")
        switch state {
        case .onGoing:
            interactor.maxSeconds = Settings.pomodoroInSeconds
        case .resting:
            interactor.maxSeconds = Settings.restingInSeconds
        }
        running = true
        interactor.start()
    }

    func stop() {
        internalStop(fromUser: true)
    }

    func reset() {
        state = .onGoing
        secondsLeft = Settings.pomodoroInSeconds
    }

    func currentProgress() -> Double {
        let maxSeconds = state == .resting ? Settings.restingInSeconds : Settings.pomodoroInSeconds
        if let secondsLeft = secondsLeft {
            return secondsLeft / maxSeconds
        }
        return 0.0
    }

    required init(interactor: PomodoroInteractorProtocol) {
        running = false
        secondsLeft = Settings.pomodoroInSeconds
        state = .onGoing
        self.interactor = interactor
        self.interactor.delegate = self
    }

    func internalStop(fromUser: Bool) {
        // If it's the user has pressed the button, stop all execution
        // If is stoped because finish time, start resting time o stop if currely resting
        assert(running == true, "Stop can't be called, if app counter is running")
        running = false
        interactor.stop()
        // check resting state
        switch state {
        case .onGoing:
            // Set pomodoro in resting mode and restart
            if fromUser == false {
                Notification.show(informativeText: "Long pomodoro finished",
                                            title: "LongPomo")
                state = .resting
                play() // Start resting
            } else {
                reset()
            }
        case .resting:
            Notification.show(informativeText: "Rest finished",
                                        title: "LongPomo")
            reset()
        }
    }

    // MARK: - PomodoroInteractorDelegate

    func timeChanged(secondsLeft: Double) {
        self.secondsLeft = secondsLeft
        if secondsLeft <= 0 {
            internalStop(fromUser: false)
        }
    }
}