//
//  SettingsViewController.swift
//  LongPomo
//
//  Created by Daniel Vela on 25/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {

    @IBOutlet weak var pomodoroTime: NSTextField!
    @IBOutlet weak var restTime: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoroTime.stringValue = Settings.pomodoroInSeconds.toMM()
        restTime.stringValue = Settings.restingInSeconds.toMM()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        if let nextPomodoroTime = Double(pomodoroTime.stringValue)?.minutes() {
            Settings.pomodoroInSeconds = nextPomodoroTime
        }
        if let nextRestTime = Double(restTime.stringValue)?.minutes() {
            Settings.restingInSeconds = nextRestTime
        }
    }

    lazy var mainWindow = {
        return NSApplication.shared().mainWindow!
    }()
    @IBAction func gearTapped(_ sender: Any) {
    }

    @IBAction func playCircleTapped(_ sender: NSButton) {
        let windowController = NSWindowController(window: mainWindow)
        windowController.contentViewController = ViewController.circleController
        windowController.showWindow(mainWindow)
    }
}
