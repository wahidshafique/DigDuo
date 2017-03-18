//
//  TextNode.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameKit

class TextNode : SKLabelNode, SimpleUI
{
    var Name: String {
        return name!
    }
    
    var getUIType: SimpleUIType {
        return .text
    }
}
