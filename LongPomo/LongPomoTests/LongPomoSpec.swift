//
//  LongPomoQuickTests.swift
//  LongPomoTests
//
//  Created by Daniel Vela on 01/03/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import Quick
import Nimble
@testable import LongPomo

class LongPomoSpec: QuickSpec {
    lazy var storyboard = {
        NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
    }()
    var controller: ViewController?

    override func setUp() {
        super.setUp()
        controller = storyboard.instantiateController(withIdentifier:
            NSStoryboard.SceneIdentifier(rawValue: "MainViewController"))
            as? ViewController
    }

    override func spec() {
        setUp()
        describe("the ViewController") {
            it("can be loaded") {
                expect(self.controller?.view).notTo(beNil())
            }

//            context("if main button is tapped") {
//                self.controller?.mainButtonTapped(NSButton())
//                it("timer must start") {
//                    expect(self.controller?.viewModel?.running).to(beTrue())
//                }
//            }
        }
    }
}
