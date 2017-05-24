//
//  TimerCircleView.swift
//  LongPomo
//
//  Created by Daniel Vela on 23/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Cocoa

class TimerCicleOvalShadow {
    var shadowRadius: CGFloat
    var shadowOpacity: Float
    var shadowOffsset: CGSize

    init() {
        self.shadowRadius = 0
        self.shadowOpacity = 0
        self.shadowOffsset = CGSize.zero
    }

    func configureShapeLayer(layer: CAShapeLayer) -> CAShapeLayer {
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffsset
        return layer
    }
}

class TimerCicleOvalLine {
    var lineWidth: CGFloat
    var strokeStart: CGFloat
    var strokeEnd: CGFloat
    var strokeColor: NSColor

    init(_ lineWidth: CGFloat, _ color: NSColor) {
        self.lineWidth = lineWidth
        self.strokeStart = 0
        self.strokeEnd = 1
        self.strokeColor = color
    }

    func configureShapeLayer(layer: CAShapeLayer) -> CAShapeLayer {
        layer.lineWidth = lineWidth
        layer.strokeStart = strokeStart
        layer.strokeEnd = strokeEnd
        layer.strokeColor = strokeColor.cgColor
        return layer
    }
}

class TimerCicleOval {
    var path: CGPath?
    var fillColor: NSColor?
    var shadow: TimerCicleOvalShadow?
    var line: TimerCicleOvalLine?

    func ovalShapeLayer() -> CAShapeLayer {
        var arc = CAShapeLayer()
        arc.path = path
        arc.fillColor = fillColor!.cgColor
        arc.shadowColor = NSColor.black.cgColor
        arc = (shadow?.configureShapeLayer(layer: arc))!
        arc = (line?.configureShapeLayer(layer: arc))!
        return arc
    }
}
class TimerCircleView: NSView {
    var primaryColor: NSColor = AppColors.primaryColor
    var secondaryColor: NSColor = AppColors.secondaryColor
    var arcRadious: CGFloat = 250
    var kLineWidth: CGFloat = 20
    var currentProgress: Double = 0 { // Valid values from 0.0 to 1.0
        didSet {
            if currentProgress > 1.0 {
                currentProgress = 1.0
            }
            if currentProgress < 0.0 {
                currentProgress = 0.0
            }
            redraw()
        }
    }

    func addOval(oval: TimerCicleOval) {
        let arc = oval.ovalShapeLayer()
        layer?.addSublayer(arc)
    }

    func ovalBottom(_ path: NSBezierPath, _ color: NSColor) -> TimerCicleOval {
        let ovalBottom = TimerCicleOval()
        ovalBottom.path = path.CGPath
        ovalBottom.fillColor = NSColor.clear

        let ovalBottomShadow = TimerCicleOvalShadow()
        ovalBottom.shadow = ovalBottomShadow

        let ovalBottomLine = TimerCicleOvalLine(kLineWidth, color)
        ovalBottom.line = ovalBottomLine

        return ovalBottom
    }

    func ovalTop(_ path: NSBezierPath, _ color: NSColor) -> TimerCicleOval {
        let ovalTop = TimerCicleOval()
        ovalTop.path = path.CGPath
        ovalTop.fillColor = NSColor.clear

        let ovalTopShadow = TimerCicleOvalShadow()
        ovalTop.shadow = ovalTopShadow

        let ovalTopLine = TimerCicleOvalLine(kLineWidth, color)
        ovalTop.line = ovalTopLine

        return ovalTop
    }

    func addCirle(arcRadius: CGFloat, colorTop: NSColor, colorBottom: NSColor) {
        let X = self.bounds.midX
        let Y = self.bounds.midY

        // Bottom Oval
        let pathBottom = NSBezierPath(ovalIn: NSRect(origin: CGPoint(x: X - (arcRadius/2),
                                                                     y: Y - (arcRadius/2)),
                                                     size: CGSize(width: arcRadius,
                                                                  height:arcRadius)))
        self.addOval(oval: ovalBottom(pathBottom, colorBottom))

        // Top Oval
        // Start 90  -> maxLeftSeconds
        // End -270  -> 0 leftSeconds
        // Dif -360 * (currentSec * maxLeftSeconds)
        let pathTop = NSBezierPath()
        pathTop.appendArc(withCenter: NSPoint(x: X, y: Y),
                          radius: arcRadius/2,
                          startAngle: 90,
                          endAngle: calculateEndAngle(), clockwise: true)
        self.addOval(oval: ovalTop(pathTop, colorTop))
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        self.addCirle(arcRadius: self.arcRadious,
                      colorTop: self.primaryColor,
                      colorBottom:  self.secondaryColor)
    }

    func redraw() {
        // invalidate view
        self.needsDisplay = true
    }

    func calculateEndAngle() -> CGFloat {
        return CGFloat((360 * currentProgress) - 270)
    }
}
