//
//  PomodoroInteractorProtocolMock.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 10/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import UIKit
@testable import LongPomo_ios

class PomodoroInteractorProtocolMock: PomodoroInteractorProtocol {
    var startCalled = false
    var stopCalled = false
    func start(from date: Date) {
        startCalled = true
    }

    func stop() {
        stopCalled = true
    }

    var maxSeconds: Double = 0.0

    var initialState: PomodoroState

    weak var delegate: PomodoroInteractorDelegate?

    init() {
        initialState = .stopped
        delegate = nil
    }
}
