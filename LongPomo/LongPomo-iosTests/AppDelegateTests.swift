//
//  AppDelegateTests.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 07/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import XCTest
@testable import LongPomo_ios
import UserNotifications

class AppDelegateTests: XCTestCase {
    var mock: RestorationManagerMock?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mock = RestorationManagerMock()
        if let mock = mock {
            RestorationManager.shared = mock
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGet() {
        XCTAssertEqual(AppDelegate.get(), UIApplication.shared.delegate as? AppDelegate)
    }

    func testApplicationWillResignActive() {
        AppDelegate.get().applicationWillResignActive(UIApplication.shared)
        XCTAssertTrue(mock?.appDeactivatedCalled ?? false)
    }

    func testApplicationDidBecomeActive() {
        AppDelegate.get().applicationDidBecomeActive(UIApplication.shared)
        XCTAssertTrue(mock?.appActivatedCalled ?? false)
    }

    func testUnneeded() {
        AppDelegate.get().applicationDidEnterBackground(UIApplication.shared)
        AppDelegate.get().applicationWillEnterForeground(UIApplication.shared)
        AppDelegate.get().applicationWillTerminate(UIApplication.shared)
    }
}
