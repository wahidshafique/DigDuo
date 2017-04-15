//
//  Player.swift
//  DigDuo
//
//  Created by Tech on 2017-04-14.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import Foundation
import SpriteKit

class Player: Animatable{
    func animationComplete(animationName: String) {
        print("anim complete")
    }

    public var sprite : SKSpriteNode
    private var playerAnimFrames:[SKTexture]!
    private let pAtlas = SKTextureAtlas(named: "PlayerAnim")
    private var walkFrames = [SKTexture]()
    
    init () {
    let texture = SKTexture(imageNamed: "Player")
    sprite = SKSpriteNode(texture: texture, color: .white, size: texture.size())
    sprite.yScale = (sprite.yScale) * -1
    
    loadAnim()
    playerAnimate()
        
    }
 
    func loadAnim() {
        let numImg = pAtlas.textureNames.count
    
        for i in 1 ..< numImg / 2 {
            let pTextureName = "Moly\(i)"
            walkFrames.append(pAtlas.textureNamed(pTextureName))
        }
        playerAnimFrames = walkFrames
    }
    
    func playerAnimate() {
        //Ttesting
        sprite.run(SKAction.repeatForever(
            SKAction.animate(with: playerAnimFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                           withKey:"walkingPlayer")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
