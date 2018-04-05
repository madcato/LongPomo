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
    @IBOutlet var timer: WKInterfaceTimer!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        scene.scaleMode = .aspectFit
        interfaceScene.presentScene(scene)
        let fraction: CGFloat = 0.75
        let path = UIBezierPath(arcCenter: .zero,
                                radius: 50,
                                startAngle: 0,
                                endAngle: 2 * .pi * fraction,
                                clockwise: true).cgPath

        let shapeNode = SKShapeNode(path: path)
        shapeNode.strokeColor = .blue
        shapeNode.fillColor = .clear
        shapeNode.lineWidth = 4
        shapeNode.lineCap = .round
        shapeNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        scene.addChild(shapeNode)

//        put SKLabelNode to show remaining time
//https://stackoverflow.com/questions/27073029/creating-progress-circle-as-wkinterfaceimage-in-watch-app/27073432#27073432
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
