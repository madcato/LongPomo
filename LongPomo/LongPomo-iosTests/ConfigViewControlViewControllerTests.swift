//
//  ConfigViewControlViewControllerTests.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 08/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import XCTest
@testable import LongPomo_ios

class ConfigViewControlViewControllerTests: XCTestCase {
    var storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self))
    var controller: ConfigViewControllViewController?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller = storyboard.instantiateViewController(withIdentifier:
            "ConfigViewControlViewController") as? ConfigViewControllViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoadViewController() {
        // This is an example of a functional test case.
        XCTAssertNotNil(controller, "ViewController not loaded")
    }

    func testDidLoadViewController() {
        // This is an example of a functional test case.
        let _ = controller?.view  // to invoke controller?.viewDidLoad()
        XCTAssertEqual(controller?.pomoDatePicker.value(forKey: "textColor") as? Color,
                       AppColors.primaryColor)
        XCTAssertEqual(controller?.restDatePicker.value(forKey: "textColor") as? Color,
                       AppColors.primaryColor)
        XCTAssertEqual(controller?.pomoDatePicker.countDownDuration, Settings.pomodoroInSeconds)
        XCTAssertEqual(controller?.restDatePicker.countDownDuration, Settings.restingInSeconds)
    }

    func testPreferedStyle() {
        XCTAssertEqual(controller?.preferredStatusBarStyle, UIStatusBarStyle.lightContent)
    }

    func testDidReceiveMemory() {
        controller?.didReceiveMemoryWarning()
    }

    func testViewToModel() {
        let _ = controller?.view  // to invoke controller?.viewDidLoad()
        Settings.pomodoroInSeconds = 0
        Settings.restingInSeconds = 0
        controller?.viewToModel()
        XCTAssertEqual(controller?.pomoDatePicker.countDownDuration, Settings.pomodoroInSeconds)
        XCTAssertEqual(controller?.restDatePicker.countDownDuration, Settings.restingInSeconds)
    }
}
