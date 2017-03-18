//
//  ButtonNode.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameKit

class ButtonNode : SKSpriteNode, SimpleUI
{
    func onTouchDown()
    {
        if !isDown {
            isDown = true
            animate()
        }
    }
    
    func onTouchUp()
    {
        if isDown {
            isDown = false
            animate()
        }
    }
    
    private func animate()
    {
        if isDown
        {
            run(SKAction.fadeAlpha(to: 0.12, duration: 0.25))
        }
        else
        {
            run(SKAction.fadeAlpha(to: 1.0, duration: 0.25))
            {
                if let closure = self.touchClosure {
                    closure()
                }
            }
        }
    }
    
    func setText(text: TextNode)
    {
        txt = text
        addChild(text)
        text.position = .zero
    }
    
    var touchClosure : (() -> Void)?
    private var txt: TextNode?
    
    private var isDown: Bool = false
    
    // properties
    var ButtonDown: Bool{
        return isDown
    }
    
    var Name: String {
        return name!
    }
    
    var getUIType : SimpleUIType {
        return .button
    }
}
