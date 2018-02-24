//
//  ConfigViewControllViewController.swift
//  LongPomo-ios
//
//  Created by Daniel Vela on 08/02/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import UIKit

class ConfigViewControllViewController: UIViewController {
    @IBOutlet weak var pomoDatePicker: UIDatePicker!
    @IBOutlet weak var restDatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureModel()
    }

    func configureView() {
        pomoDatePicker.setValue(AppColors.primaryColor, forKey: "textColor")
        restDatePicker.setValue(AppColors.primaryColor, forKey: "textColor")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    func configureModel() {
        pomoDatePicker.countDownDuration = Settings.pomodoroInSeconds
        restDatePicker.countDownDuration = Settings.restingInSeconds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewToModel() {
        Settings.pomodoroInSeconds = pomoDatePicker.countDownDuration
        Settings.restingInSeconds = restDatePicker.countDownDuration
    }
}
