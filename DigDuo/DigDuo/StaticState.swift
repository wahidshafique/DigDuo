//
//  StaticState.swift
//  DigDuo
//
//  Created by Tech on 2017-04-16.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class StaticState: GKState {
    unowned let scene: GameScene
    var sprite: SKSpriteNode
    
    init(scene: SKScene, sprite: SKSpriteNode) {
        self.scene = scene as! GameScene
        self.sprite = sprite
    }
    
    /* pause anim state*/
    override func didEnter(from previousState: GKState?) {
        sprite.removeAction(forKey: "walkingPlayer")
    }
    
    /* determines valid states for transitioning */
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is MovingState.Type
    }
}
