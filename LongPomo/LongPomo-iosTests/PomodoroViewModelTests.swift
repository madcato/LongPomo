//
//  PomodoroViewModelTests.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 10/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import XCTest
@testable import LongPomo_ios

class PomodoroViewModelTests: XCTestCase {
    var pomodoroInteractorMock = PomodoroInteractorProtocolMock()
    var pomodoroVM: PomodoroViewModel?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        pomodoroInteractorMock = PomodoroInteractorProtocolMock()
        pomodoroVM = PomodoroViewModel(interactor: pomodoroInteractorMock)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPlay() {
        pomodoroVM?.play()
        XCTAssertTrue(pomodoroInteractorMock.startCalled)
        XCTAssertTrue(pomodoroVM?.running ?? false)
        XCTAssertEqual(pomodoroVM?.state ?? PomodoroState.resting, PomodoroState.onGoing)
        XCTAssertEqual(pomodoroInteractorMock.maxSeconds, Settings.pomodoroInSeconds)
        pomodoroVM?.stop()
    }

    func testStop() {
        pomodoroVM?.play()
        pomodoroVM?.stop()
        XCTAssertTrue(pomodoroInteractorMock.stopCalled)
        XCTAssertFalse(pomodoroVM?.running ?? true)
        XCTAssertEqual(pomodoroVM?.state ?? PomodoroState.resting, PomodoroState.stopped)
        XCTAssertEqual(pomodoroInteractorMock.maxSeconds, Settings.pomodoroInSeconds)
    }

    func testInternalStop1() {
        pomodoroVM?.play()
        pomodoroVM?.internalStop(fromUser: true)
        XCTAssertTrue(pomodoroInteractorMock.startCalled)
        XCTAssertFalse(pomodoroVM?.running ?? true)
        XCTAssertEqual(pomodoroVM?.state ?? PomodoroState.resting, PomodoroState.stopped)
        XCTAssertEqual(pomodoroInteractorMock.maxSeconds, Settings.pomodoroInSeconds)
    }

    func testInternalStop2() {
        pomodoroVM?.play()
        pomodoroVM?.internalStop(fromUser: false)
        XCTAssertTrue(pomodoroInteractorMock.startCalled)
        XCTAssertTrue(pomodoroVM?.running ?? false)
        XCTAssertEqual(pomodoroVM?.state ?? PomodoroState.stopped, PomodoroState.resting)
        XCTAssertEqual(pomodoroInteractorMock.maxSeconds, Settings.restingInSeconds)
    }
}
