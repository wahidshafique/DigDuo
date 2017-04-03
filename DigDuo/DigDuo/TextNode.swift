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
    
    func adjustLabelFontSizeToFitRect(rect:CGRect, scale: CGFloat) {
        
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        let scalingFactor = min(rect.width / self.frame.width * scale, rect.height / self.frame.height * scale)
        
        // Change the fontSize.
        self.fontSize *= scalingFactor
        
        // Optionally move the SKLabelNode to the center of the rectangle.
        //self.position = CGPoint(x: rect.midX, y: rect.midY - self.frame.height / 2.0)
    }
}
