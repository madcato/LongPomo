//
//  SettingsController.swift
//  LonPomo-watch Extension
//
//  Created by Daniel Vela on 07/04/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import WatchKit
import Foundation

class SettingsController: WKInterfaceController {
    @IBOutlet var timeMinutesPicker: WKInterfacePicker!
    @IBOutlet var restMinutesPicker: WKInterfacePicker!
    @IBOutlet var restLabel: WKInterfaceLabel!
    @IBOutlet var focusLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        buildPickers()
        configureView()
        configureModel()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func configureView() {
       focusLabel.setTextColor(AppColors.primaryColor)
        restLabel.setTextColor(AppColors.accentColor)
    }

    func buildPickers() {
        var minutes: [WKPickerItem] = []
        for minute in 0...90 {
            let item = WKPickerItem()
            item.caption = "min"
            item.title = "\(minute)"
            minutes.append(item)
        }
        timeMinutesPicker.setItems(minutes)
        restMinutesPicker.setItems(minutes)
    }

    func configureModel() {
        let indexTime: Int = Int(Settings.pomodoroInSeconds / 60)
        timeMinutesPicker.setSelectedItemIndex(indexTime)
        let indexRest: Int = Int(Settings.restingInSeconds / 60)
        restMinutesPicker.setSelectedItemIndex(indexRest)
    }

    @IBAction func timeMinutesAction(_ value: Int) {
        Settings.pomodoroInSeconds = Double(value) * 60.0 // minutes
        WKInterfaceDevice.current().play(WKHapticType.click)
    }

    @IBAction func restMinutesAction(_ value: Int) {
        Settings.restingInSeconds = Double(value) * 60.0 // minutes
        WKInterfaceDevice.current().play(WKHapticType.click)
    }
}
