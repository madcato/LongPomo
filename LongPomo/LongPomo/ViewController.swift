//
//  ViewController.swift
//  LongPomo
//
//  Created by Daniel Vela on 18/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var mainButton: NSButton!
    @IBOutlet weak var timeLeft: NSTextField!

    var viewModel: PomodoroViewModelProtocol? {
        didSet {
            viewModel?.runningDidChange = { [unowned self] viewModel in
                if viewModel.running {
                    self.mainButton.image = NSImage(named: "square")
                } else {
                    self.mainButton.image = NSImage(named: "triangle")
                }
            }
            viewModel?.sencondsLeftDidChange = { [unowned self] viewModel in
                if let seconds = viewModel.secondsLeft {
                    self.timeLeft.stringValue = seconds.toMMSS()
                } else {
                    self.timeLeft.stringValue = Settings.pomodoroInSeconds.toMMSS()
                }
            }
            self.timeLeft.stringValue = ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureViewModel()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func configureAppearance() {
    }

    func configureViewModel() {
        let interactor = PomodoroInteractor(maxSeconds: Settings.pomodoroInSeconds)
        let pomodoroViewModel = PomodoroViewModel(interactor: interactor)
        viewModel = pomodoroViewModel
    }

    @IBAction func mainButtonTapped(_ sender: Any) {
        guard let running = viewModel?.running else { return }
        if running {
            viewModel?.stop()
        } else {
            viewModel?.play()
        }
    }

    @IBAction func gearTapped(_ sender: Any) {
    }

    @IBAction func playCircleTapped(_ sender: NSButton) {
    }
}
