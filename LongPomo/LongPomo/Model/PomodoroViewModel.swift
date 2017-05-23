//
//  PomodoroViewModel.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

protocol PomodoroViewModelProtocol {
    var running: Bool { get }
    var runningDidChange: ((PomodoroViewModelProtocol) -> Void)? { get set }

    var secondsLeft: Double? { get }
    var sencondsLeftDidChange: ((PomodoroViewModelProtocol) -> Void)? { get set }

    func play()
    func stop()

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

    var interactor: PomodoroInteractorProtocol

    func play() {
        assert(running == false, "Play can't be called, if app counter is running")
        running = true
        interactor.start()
    }

    func stop() {
        assert(running == true, "Stop can't be called, if app counter is running")
        running = false
        interactor.stop()
        // FIXME Change the Pomodoro to rest mode 
    }

    required init(interactor: PomodoroInteractorProtocol) {
        running = false
        secondsLeft = Settings.pomodoroInSeconds
        self.interactor = interactor
        self.interactor.delegate = self
    }

    // MARK - PomodoroInteractorDelegate

    func timeChanged(secondsLeft: Double) {
        self.secondsLeft = secondsLeft
        if secondsLeft <= 0 {
            stop()
        }
    }
}
