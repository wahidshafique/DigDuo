//
//  PlayerEntity.swift
//  DigDuo
//
//  Created by Tech on 2017-04-15.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import GameplayKit

class PlayerEntity: GKEntity {
    var pos: CGPoint!
    
    /* main init */
    init(pos: CGPoint) {
        self.pos = pos
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
