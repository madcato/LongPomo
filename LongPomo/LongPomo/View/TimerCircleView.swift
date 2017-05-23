//
//  TimerCircleView.swift
//  LongPomo
//
//  Created by Daniel Vela on 23/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Cocoa

class TimerCircleView: NSView {
    var primaryColor: NSColor = AppColors.primaryColor
    var secondaryColor: NSColor?
    var arcRadious: CGFloat = 20

    func addOval(lineWidth: CGFloat,
                 path: CGPath,
                 strokeStart: CGFloat,
                 strokeEnd: CGFloat,
                 strokeColor: NSColor,
                 fillColor: NSColor,
                 shadowRadius: CGFloat,
                 shadowOpacity: Float,
                 shadowOffsset: CGSize) {
        let arc = CAShapeLayer()
        arc.lineWidth = lineWidth
        arc.path = path
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = strokeColor.cgColor
        arc.fillColor = fillColor.cgColor
        arc.shadowColor = NSColor.black.cgColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffsset
        layer?.addSublayer(arc)
    }

    func addCirle(arcRadius: CGFloat, capRadius: CGFloat, color: NSColor) {
        let X = self.bounds.midX
        let Y = self.bounds.midY
        // Bottom Oval
        let pathBottom = NSBezierPath(ovalIn: NSRect(origin: CGPoint(x: X - (arcRadius/2),
                                                                     y: Y - (arcRadius/2)),
                                                     size: CGSize(width: arcRadius,
                                                                  height:arcRadius)))
        self.addOval(lineWidth: 20.0,
                     path: pathBottom.CGPath,
                     strokeStart: 0,
                     strokeEnd: 0.5,
                     strokeColor: color,
                     fillColor: NSColor.clear,
                     shadowRadius: 0,
                     shadowOpacity: 0,
                     shadowOffsset: CGSize.zero)
        // Middle Cap
        let pathMiddle = NSBezierPath(ovalIn: NSRect(origin: CGPoint(x: (X - (capRadius/2)) - (arcRadius/2),
                                                                     y: Y - (capRadius/2)),
                                                     size: CGSize(width: capRadius,
                                                                  height:capRadius)))
        self.addOval(lineWidth: 0.0,
                     path: pathMiddle.CGPath,
                     strokeStart: 0,
                     strokeEnd: 1.0,
                     strokeColor: color,
                     fillColor: color,
                     shadowRadius: 5.0,
                     shadowOpacity: 0.5,
                     shadowOffsset: CGSize.zero)

        // Top Oval
        let pathTop = NSBezierPath(ovalIn: NSRect(origin: CGPoint(x: X - (arcRadius/2),
                                                                  y: Y - (arcRadius/2)),
                                                  size: CGSize(width: arcRadius,
                                                               height:arcRadius)))
        self.addOval(lineWidth: 20.0,
                     path: pathTop.CGPath,
                     strokeStart: 0.5,
                     strokeEnd: 1.0,
                     strokeColor: color,
                     fillColor: NSColor.clear,
                     shadowRadius: 0,
                     shadowOpacity: 0,
                     shadowOffsset: CGSize.zero)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        self.addCirle(arcRadius: self.arcRadious, capRadius: 20, color: self.primaryColor)
    }
}
