//
//  isSafe.swift
//  DigDuo
//
//  Created by Tech on 2017-04-15.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

//remove actionables when enemy might be out of range?

import SpriteKit
import GameplayKit

class IsSafe: GKState {
    unowned let scene: GameScene
    var sprite: SKSpriteNode
    
    /* main init */
    init(scene: SKScene, sprite: SKSpriteNode) {
        self.scene = scene as! GameScene
        self.sprite = sprite
    }
    
    /* removes red tint color from the sprite */
    override func didEnter(from previousState: GKState?) {
        let colorize = SKAction.colorize(with: SKColor.clear, colorBlendFactor: 0.0, duration: 0.05)
        sprite.run(colorize)
    }
    
    /* determines valid states for transitioning */
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is inRange.Type
    }
}
