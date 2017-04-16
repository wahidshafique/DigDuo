//
//  CameraComponent.swift
//  DigDuo
//
//  Created by Tech on 2017-04-16.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class CameraComponent: GKComponent {
    unowned let scene: GameScene
    let sprite: SKSpriteNode
    var camera: SKCameraNode
    
    init(scene: SKScene, sprite: SKSpriteNode) {
        self.scene = scene.self as! GameScene
        self.camera = SKCameraNode()
        self.sprite = sprite
        super.init()
        cameraSpawn()
    }
    
    func cameraSpawn() {
        //todo, migrate to world..
        let cam = SKCameraNode()
        self.camera = cam
        camera.setScale(2.0)
        // Constrain the camera to stay a constant distance of 0 points from the player node.
        let zeroRange = SKRange(constantValue: 0.0)
        let playerLocationConstraint = SKConstraint.distance(zeroRange, to: sprite)
        
        // get the scene size as scaled by `scaleMode = .AspectFill`
        let scaledSize = CGSize(width: scene.size.width * (camera.xScale), height: scene.size.height * (camera.yScale))
        
        // get the frame of the entire level contents
        let boardNode = scene.background
        let boardContentRect = boardNode?.calculateAccumulatedFrame()
        
        // inset that frame from the edges of the level
        // (no need for `- 100` if you want zero padding)
        // use min() to make sure we don't inset too far if the level is small
        let xInset = min((scaledSize.width / 2) - 100.0, (boardContentRect?.width)! / 2)
        let yInset = min((scaledSize.height / 2) - 100.0, (boardContentRect?.height)! - (boardNode?.size.height)!)
        let insetContentRect = boardContentRect?.insetBy(dx: xInset, dy: yInset)

        // use the corners of the inset as the X and Y range of a position constraint
        let xRange = SKRange(lowerLimit: (insetContentRect?.minX)!, upperLimit: (insetContentRect?.maxX)!)
        let yRange = SKRange(lowerLimit: (insetContentRect?.minY)!, upperLimit: (insetContentRect?.maxY)!)
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        levelEdgeConstraint.referenceNode = boardNode
        cam.constraints = [playerLocationConstraint, levelEdgeConstraint]
        scene.addChild(cam)
        //cam?.addChild(ui!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
