//
//  MovingState.swift
//  DigDuo
//
//  Created by Tech on 2017-04-16.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class MovingState: GKState {
    unowned let scene: GameScene
    var sprite: SKSpriteNode
    var playerAnimFrames:[SKTexture]!
    let pAtlas:SKTextureAtlas
    var walkFrames = [SKTexture]()
    let numImg:Int
    
    init(scene: SKScene, sprite: SKSpriteNode) {
        self.scene = scene as! GameScene
        self.sprite = sprite
        self.pAtlas = SKTextureAtlas(named: "PlayerAnim")
        self.numImg = pAtlas.textureNames.count
    }
    
    /* make the player animate */
    override func didEnter(from previousState: GKState?) {
        for i in 1 ..< numImg / 2 {
            let pTextureName = "Moly\(i)"
            walkFrames.append(pAtlas.textureNamed(pTextureName))
        }
        playerAnimFrames = walkFrames
        sprite.run(SKAction.repeatForever(
            SKAction.animate(with: playerAnimFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                   withKey:"walkingPlayer")
    }
    
    /* determines validity */
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is StaticState.Type
    }
}
