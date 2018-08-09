//
//  PomodoroInteractorTests.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 09/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import XCTest
@testable import LongPomo_ios

class PomodoroInteractorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        PomodoroInteractor.shared.maxSeconds = 0
        PomodoroInteractor.shared.initialState = .stopped
        PomodoroInteractor.shared.startTime = nil
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExists() {
        XCTAssertNotNil(PomodoroInteractor.shared)
        XCTAssertEqual(PomodoroInteractor.shared.maxSeconds, 0)
        XCTAssertEqual(PomodoroInteractor.shared.initialState, .stopped)
        XCTAssertNil(PomodoroInteractor.shared.startTime)
    }

    func testChangeInitialState() {
        let delegate = PomodoroInteractorDelegateMock()
        PomodoroInteractor.shared.delegate = delegate
        PomodoroInteractor.shared.initialState = PomodoroState.onGoing
        XCTAssertTrue(delegate.stateChangedFromInteractorCalled)
    }

    func testChangeMaxSeconds() {
        PomodoroInteractor.shared.maxSeconds = 30.0
        XCTAssertEqual(PomodoroInteractor.shared.secondsLeft, 30.0)
    }

    func testStart() {
        PomodoroInteractor.shared.start(from: Date())
        XCTAssertEqual(PomodoroInteractor.shared.timer.isValid, true)
    }

    func testStop() {
        PomodoroInteractor.shared.start(from: Date())
        XCTAssertEqual(PomodoroInteractor.shared.timer.isValid, true)
        PomodoroInteractor.shared.stop()
        XCTAssertEqual(PomodoroInteractor.shared.timer.isValid, false)
        XCTAssertNil(PomodoroInteractor.shared.startTime)
    }
}
