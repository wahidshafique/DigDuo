//
//  Animatable.swift
//  DigDuo
//
//  Created by Tech on 2017-04-03.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit

protocol Animatable : class
{
    func animationComplete(animationName: String)
    
    var sprite : SKSpriteNode
    {
        get
        set
    }
}
