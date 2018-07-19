//
//  TimeCircleView.swift
//  LonPomo-watch Extension
//
//  Created by Daniel Vela on 07/04/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import WatchKit
import SpriteKit

class TimeCircleView: SKScene {
    var timeLabel: SKLabelNode?
    var primaryColor = AppColors.primaryColor
    var currentProgress: Double = 1.0 { // Valid values from 0.0 to 1.0
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

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(size: CGSize) {
        super.init(size: size)
        self.scaleMode = .aspectFit
        self.backgroundColor = AppColors.backgroundColor
        // Gray path
        let path = UIBezierPath(arcCenter: .zero,
                                radius: 45,
                                startAngle: 0,
                                endAngle: 2 * .pi,
                                clockwise: true).cgPath
        let shapeNode = SKShapeNode(path: path)
        shapeNode.strokeColor = AppColors.secondaryColor
        shapeNode.fillColor = .clear
        shapeNode.lineWidth = 10
        shapeNode.lineCap = .round
        shapeNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(shapeNode)
        draw()
        createLabel()
        //        put SKLabelNode to show remaining time
        //https://stackoverflow.com/questions/27073029/creating-
        // progress-circle-as-wkinterfaceimage-in-watch-app
        // /27073432#27073432

    }
    func createLabel() {
        timeLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        timeLabel?.text = "57:12"
        timeLabel?.fontSize = 22
        timeLabel?.fontColor = primaryColor
        timeLabel?.position  = CGPoint(x: frame.midX, y: frame.midY)
        timeLabel?.verticalAlignmentMode = .center
        timeLabel?.horizontalAlignmentMode = .center
        addChild(timeLabel!)
    }

    let initAngle = (CGFloat.pi / 2)
    var shapeNodeY: SKShapeNode?
    func draw() {
        // Yellow path
        let pathY = UIBezierPath(arcCenter: .zero,
                                 radius: 45,
                                 startAngle: (.pi / 2),
                                 endAngle: calculateEndAngle(),
                                 clockwise: false).cgPath
        shapeNodeY = SKShapeNode(path: pathY)
        shapeNodeY?.strokeColor = primaryColor
        shapeNodeY?.fillColor = .clear
        shapeNodeY?.lineWidth = 10
        shapeNodeY?.lineCap = .round
        shapeNodeY?.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(shapeNodeY!)
    }

    func redraw() {
        timeLabel?.fontColor = primaryColor
        shapeNodeY?.removeFromParent()
        draw()
    }

    func calculateEndAngle() -> CGFloat {
        let reverseProgress = CGFloat(1 - currentProgress)
        let fullCircle = 2 * CGFloat.pi
        return initAngle - (fullCircle * reverseProgress)
    }
}
