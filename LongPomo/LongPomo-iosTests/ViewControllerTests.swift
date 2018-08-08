//
//  ViewControllerTests.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 07/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import XCTest
@testable import LongPomo_ios

class ViewControllerTests: XCTestCase {
    var storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self))

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoadViewController() {
        // This is an example of a functional test case.
        let controller = storyboard.instantiateInitialViewController()
        XCTAssertNotNil(controller, "ViewController not loaded")
    }
}
