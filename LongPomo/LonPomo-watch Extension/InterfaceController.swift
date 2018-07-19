//
//  InterfaceController.swift
//  LonPomo-watch Extension
//
//  Created by Daniel Vela on 12/02/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit

class InterfaceController: WKInterfaceController {
    @IBOutlet var interfaceScene: WKInterfaceSKScene!
    var scene: TimeCircleView?
    @IBOutlet var tapGesture: WKTapGestureRecognizer!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        scene = TimeCircleView(size: CGSize(width: 100, height: 100))
        interfaceScene.presentScene(scene!)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        configureViewModel()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    var viewModel: PomodoroViewModelProtocol? {
        didSet {
            viewModel?.runningDidChange = self.runningDidChange
            viewModel?.sencondsLeftDidChange = self.secondsLeftDidChange
            viewModel?.stateDidChange = self.stateDidChange
            if let seconds = viewModel?.secondsLeft {
                self.scene?.timeLabel?.text = seconds.toMMSS()
            }
        }
    }

    func runningDidChange(viewModel: PomodoroViewModelProtocol) {
        if viewModel.running {
//            self.startStopButton.setTitle("Stop", for: .normal)
        } else {
//            self.startStopButton.setTitle("Start", for: .normal)
        }
    }

    func secondsLeftDidChange(viewModel: PomodoroViewModelProtocol) {
        if let seconds = viewModel.secondsLeft {
            self.scene?.timeLabel?.text = seconds.toMMSS()
            var progress = viewModel.currentProgress()
            // If resting, progress must start at 1 and end at 0
            if viewModel.state == .resting {
                progress = 1 - progress
            }
            if viewModel.state == .stopped {
                progress = 1
            }
            self.scene?.currentProgress = progress
        } else {
            self.scene?.timeLabel?.text = Settings.pomodoroInSeconds.toMMSS()
            self.scene?.currentProgress = 0
        }
    }

    func stateDidChange(viewModel: PomodoroViewModelProtocol) {
        switch viewModel.state {
        case .stopped, .onGoing:
            self.scene?.primaryColor = AppColors.primaryColor
            self.scene?.timeLabel?.color = AppColors.primaryColor
        case .resting:
            self.scene?.primaryColor = AppColors.accentColor
            self.scene?.timeLabel?.color = AppColors.accentColor
        }
    }

    func configureViewModel() {
        guard viewModel == nil else {
            return
        }
        let interactor = PomodoroInteractor.shared
        let pomodoroViewModel = PomodoroViewModel(interactor: interactor)
        viewModel = pomodoroViewModel
    }

    @IBAction func sceneTapped(_ sender: Any) {
        guard let running = viewModel?.running else { return }
        if running {
            viewModel?.stop()
        } else {
            viewModel?.play()
        }
    }
}
