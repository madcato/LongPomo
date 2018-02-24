//
//  ViewController.swift
//  LongPomo-ios
//
//  Created by Daniel Vela on 08/02/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeCircleView: TimerCircleView!

    var viewModel: PomodoroViewModelProtocol? {
        didSet {
            viewModel?.runningDidChange = self.runningDidChange
            viewModel?.sencondsLeftDidChange = self.secondsLeftDidChange
            viewModel?.stateDidChange = self.stateDidChange
            self.timeLabel.text = ""
        }
    }

    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        if let controller = unwindSegue.source as? ConfigViewControllViewController {
            controller.viewToModel()
        }
        if viewModel?.state == .stopped {
            viewModel?.reset()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
        viewModel?.reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    func configureView() {
    }

    func configureViewModel() {
        let interactor = PomodoroInteractor(maxSeconds: Settings.pomodoroInSeconds)
        let pomodoroViewModel = PomodoroViewModel(interactor: interactor)
        viewModel = pomodoroViewModel
    }

    func runningDidChange(viewModel: PomodoroViewModelProtocol) {
        if viewModel.running {
            self.startStopButton.setTitle("Stop", for: .normal)
        } else {
            self.startStopButton.setTitle("Start", for: .normal)
        }
    }

    func secondsLeftDidChange(viewModel: PomodoroViewModelProtocol) {
        if let seconds = viewModel.secondsLeft {
            self.timeLabel.text = seconds.toMMSS()
            var progress = viewModel.currentProgress()
            // If resting, progress must start at 1 and end at 0
            if viewModel.state == .resting {
                progress = 1 - progress
            }
            if viewModel.state == .stopped {
                progress = 1
            }
            self.timeCircleView.currentProgress = progress
        } else {
            self.timeLabel.text = Settings.pomodoroInSeconds.toMMSS()
            self.timeCircleView.currentProgress = 0
        }
    }

    func stateDidChange(viewModel: PomodoroViewModelProtocol) {
        switch viewModel.state {
        case .stopped, .onGoing:
            self.timeCircleView.primaryColor = AppColors.primaryColor
            self.timeLabel.textColor = AppColors.primaryColor
        case .resting:
            self.timeCircleView.primaryColor = AppColors.accentColor
            self.timeLabel.textColor = AppColors.accentColor
        }
    }

    @IBAction func startStopTapped(_ sender: Any) {
        guard let running = viewModel?.running else { return }
        if running {
            viewModel?.stop()
        } else {
            viewModel?.play()
        }
    }
}
