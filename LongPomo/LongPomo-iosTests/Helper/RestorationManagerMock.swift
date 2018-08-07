//
//  RestorationManagerMock.swift
//  LongPomo-iosTests
//
//  Created by Daniel Vela Angulo on 07/08/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

@testable import LongPomo_ios

class RestorationManagerMock: RestorationManager {
    var appActivatedCalled: Bool = false
    var appDeactivatedCalled: Bool = false

    override func appActivated() {
        appActivatedCalled = true
    }

    override func appDeactivated() {
        appDeactivatedCalled = true
    }
}
