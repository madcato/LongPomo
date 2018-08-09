//
//  LongPomoNotificationManagerTests.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 09/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import XCTest
@testable import LongPomo_ios
import UserNotifications

class LongPomoNotificationManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExists() {
        XCTAssertNotNil(LongPomoNotificationManager.shared)
    }

    func testsResetNotifications() {
        let center = UNUserNotificationCenter.current()
        LongPomoNotificationManager.shared.scheduleNotification(for: 3.3, message: "Hola")
        center.getPendingNotificationRequests { (vector) in
            XCTAssertEqual(vector.count, 1)
        }
        LongPomoNotificationManager.shared.resetNotifications()
        center.getPendingNotificationRequests { (vector) in
            XCTAssertEqual(vector.count, 0)
        }
    }

    func testsScheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        LongPomoNotificationManager.shared.scheduleNotifications(for: 5.0, andfor: 10.0)
        center.getPendingNotificationRequests { (vector) in
            XCTAssertEqual(vector.count, 2)
        }
    }
}
