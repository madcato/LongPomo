//
//  ColorBlockView.swift
//  LongPomo
//
//  Created by Daniel Vela on 14/02/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import Cocoa

class ColorBlockView: NSView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
    }

    var cornerRounding: CGFloat = 10 {
        didSet {
            layer?.cornerRadius = cornerRounding
        }
    }

    var blockColor: NSColor = NSColor.gray {
        didSet {
            layer?.backgroundColor = blockColor.cgColor
        }
    }

    override func prepareForInterfaceBuilder() {
        layer?.backgroundColor = blockColor.cgColor
        layer?.cornerRadius = cornerRounding
    }

    override func awakeFromNib() {
        layer?.backgroundColor = blockColor.cgColor
        layer?.cornerRadius = cornerRounding
    }
}
