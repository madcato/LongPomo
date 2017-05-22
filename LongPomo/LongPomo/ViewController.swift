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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func configureAppearance() {
    }

    @IBAction func mainButtonTapped(_ sender: Any) {
    }
}
