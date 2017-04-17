//
//  Scorer.swift
//  DigDuo
//
//  Created by Tech on 2017-04-16.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scorer {
    private let userdefs = UserDefaults.standard
    public var score: Int = 0
    
    func incScore(value: Int) {
        score += value
    }
    
    func getSetAllScoresSorted () -> Array<Int> {
        
        var highScoreList = [Int](repeating: 0, count: 5)
        
        for i in 0...highScoreList.count - 1 {
            if (!isKeyPresentInUserDefaults(key: "Leader\(i)")) {
                userdefs.set(0, forKey: "Leader\(i)")
            }
            highScoreList.append(userdefs.value(forKey: "Leader\(i)") as! Int)
            print(userdefs.value(forKey: "Leader\(i)") as Any)
        }
        
        for i in 0...highScoreList.count - 1 {
            if (score > highScoreList[i]) {
                highScoreList.insert(score, at: i)
                break;
            }
        }
        
        for i in 0...highScoreList.count - 1 {
            userdefs.set(highScoreList[i], forKey: "Leader\(i)")
        }
        
        return highScoreList
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.integer(forKey: key) > 0
    }
}
