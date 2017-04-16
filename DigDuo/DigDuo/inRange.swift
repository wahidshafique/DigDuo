//
//  inRange.swift
//  DigDuo
//
//  Created by Tech on 2017-04-15.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//


//TODO, HOOK THESE UP
//maybe for when the enemy is close to the player, or vv
import SpriteKit
import GameplayKit

class inRange: GKState {
    
    unowned let scene: GameScene
    var sprite: SKSpriteNode
    
    /* main init */
    init(scene: SKScene, sprite: SKSpriteNode) {
        self.scene = scene as! GameScene
        self.sprite = sprite
    }
    
    //just change color once the enemy? is near player
    override func didEnter(from previousState: GKState?) {
        let colorize = SKAction.colorize(with: SKColor.red, colorBlendFactor: 0.50, duration: 0.05)
        sprite.run(colorize)
    }
    
    /* determines valid states for transitioning */
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is IsSafe.Type
    }
}
