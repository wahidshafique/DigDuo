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
    
    init () {
    let texture = SKTexture(imageNamed: "Player")
    sprite = SKSpriteNode(texture: texture, color: .white, size: texture.size())
    sprite.yScale = (sprite.yScale) * -1

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
