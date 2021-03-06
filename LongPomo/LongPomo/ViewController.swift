//
//  ViewController.swift
//  LongPomo
//
//  Created by Daniel Vela on 18/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    static var circleController: NSViewController?

    @IBOutlet weak var mainButton: NSButton!
    @IBOutlet weak var timeLeft: NSTextField!

    @IBOutlet var circleView: TimerCircleView!

    var viewModel: PomodoroViewModelProtocol? {
        didSet {
            viewModel?.runningDidChange = self.runningDidChange
            viewModel?.sencondsLeftDidChange = self.secondsLeftDidChange
            viewModel?.stateDidChange = self.stateDidChange
            self.timeLeft.stringValue = ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        viewModel?.reset()
        ViewController.circleController = self
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    }

    override func viewDidAppear() {
        // any additional code
        view.window!.styleMask.remove(NSWindow.StyleMask.resizable)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func configureViewModel() {
        let interactor = PomodoroInteractor.shared
        let pomodoroViewModel = PomodoroViewModel(interactor: interactor)
        viewModel = pomodoroViewModel
    }

    func runningDidChange(viewModel: PomodoroViewModelProtocol) {
        if viewModel.running {
            self.mainButton.image = NSImage(named: NSImage.Name(rawValue: "square"))
        } else {
            self.mainButton.image = NSImage(named: NSImage.Name(rawValue: "triangle"))
        }
    }

    func secondsLeftDidChange(viewModel: PomodoroViewModelProtocol) {
        if let seconds = viewModel.secondsLeft {
            self.timeLeft.stringValue = seconds.toMMSS()
            var progress = viewModel.currentProgress()
            // If resting, progress must start at 1 and end at 0
            if viewModel.state == .resting {
                progress = 1 - progress
            }
            if viewModel.state == .stopped {
                progress = 1
            }
            self.circleView.currentProgress = progress
        } else {
            self.timeLeft.stringValue = Settings.pomodoroInSeconds.toMMSS()
            self.circleView.currentProgress = 0
        }
    }

    func stateDidChange(viewModel: PomodoroViewModelProtocol) {
        switch viewModel.state {
        case .stopped, .onGoing:
            self.circleView.primaryColor = AppColors.primaryColor
        case .resting:
            self.circleView.primaryColor = AppColors.accentColor
        }
    }

    @IBAction func mainButtonTapped(_ sender: Any) {
        guard let running = viewModel?.running else { return }
        if running {
            viewModel?.stop()
        } else {
            viewModel?.play()
        }
    }

    lazy var mainWindow = {
        return NSApplication.shared.mainWindow!
    }()
    @IBAction func gearTapped(_ sender: Any) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        if let controller = storyboard.instantiateController(withIdentifier:
            NSStoryboard.SceneIdentifier(rawValue: "SettingsViewController"))
            as? SettingsViewController {
            let windowController = NSWindowController(window: mainWindow)
            windowController.contentViewController = controller
            windowController.showWindow(mainWindow)
        }
    }

    @IBAction func playCircleTapped(_ sender: NSButton) {
    }
}
