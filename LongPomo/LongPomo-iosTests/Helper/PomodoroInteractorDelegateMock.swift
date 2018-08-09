//
//  PomodoroInteractorDelegateMock.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 09/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import UIKit
@testable import LongPomo_ios

class PomodoroInteractorDelegateMock: PomodoroInteractorDelegate {
    var timeChangedCalled = false
    var stateChangedFromInteractorCalled = false
    func timeChanged(secondsLeft: Double) {
        timeChangedCalled = true
    }

    func stateChangedFromInteractor(_ newState: PomodoroState) {
        stateChangedFromInteractorCalled = true
    }
}
