//
//  SettingsViewControllerTests.swift
//  LongPomo
//
//  Created by Daniel Vela on 26/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import XCTest
@testable import LongPomo

class SettingsViewControllerTests: XCTestCase {
    lazy var storyboard = {
        NSStoryboard(name: "Main", bundle: nil)
    }()
    var controller: SettingsViewController?
    override func setUp() {
        super.setUp()

        controller = storyboard.instantiateController(withIdentifier: "SettingsViewController")
            as? SettingsViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoad() {
        controller?.loadView()
    }

    func testDesappear() {
        controller?.loadView()
        controller?.viewWillDisappear()
    }

    func testsGearTapped() {
        controller?.loadView()
        controller?.gearTapped(10)
    }

    func testsCircleTapped() {
        controller?.loadView()
        controller?.playCircleTapped(NSButton())
    }
}
