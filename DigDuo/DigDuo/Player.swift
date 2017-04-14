//
//  Player.swift
//  DigDuo
//
//  Created by Tech on 2017-04-14.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import Foundation
import SpriteKit

class Player:SKSpriteNode{
    init () {
    let texture = SKTexture(imageNamed: "Player")
    super.init(texture: texture, color: .white, size: texture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
