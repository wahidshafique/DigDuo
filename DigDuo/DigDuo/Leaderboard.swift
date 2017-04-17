//
//  MainMenu.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class Leaderboard: SKScene {
    private var scoreList = [Int]()
    private var ui : UserInterface?
    private var uiElementNames = [String]()
    private var background: SKSpriteNode?
    private var npc: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let scoreIt = Scorer()
        scoreList = scoreIt.getSetAllScoresSorted()

        
        let dimensions = getDimensionsInScreen()
        ui = UserInterface(size: CGSize(width: dimensions.width, height: dimensions.height))
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"), color: .white, size: dimensions)
        background?.blendMode = .replace
        background?.zPosition = 0
        background?.colorBlendFactor = 1.0
        addChild(background!)
        background!.position += CGVector(dx: dimensions.width/2.0, dy: dimensions.height/2.0)
        
        let tex = SKTexture(imageNamed: "NPC")
        npc = SKSpriteNode(texture: tex, color: .black, size: tex.size())
        
        npc?.zPosition = 1
        npc?.colorBlendFactor = 1.0
        addChild(npc!)
        npc!.position += CGVector(dx: dimensions.width/2.0, dy: dimensions.height/2.0)
        
        npc!.run(SKAction.repeatForever(SKAction.rotate(byAngle: 360, duration: 1.25)))
        npc!.run(SKAction.repeatForever(SKAction.sequence([.scale(to: 2.0, duration: 1.0), .scale(to: 1.0, duration: 1.0)])))
        
        addChild(ui!)
        
        let maintxt = ui?.AddText(name: "txt-leaderboard", text: "LEADERBOARD", uiPos: CGPoint(x: 50, y: 75), fontColor: .red, size: 56.0)
        
        let score1txt = ui?.AddText(name: "txt-score1", text: "1. \(scoreList[0])", uiPos: CGPoint(x: 50, y: 60), fontColor: .yellow, size: 48.0)
        let score2txt = ui?.AddText(name: "txt-score2", text: "2. \(scoreList[1])", uiPos: CGPoint(x: 50, y: 55), fontColor: .yellow, size: 44.0)
        let score3txt = ui?.AddText(name: "txt-score3", text: "3. \(scoreList[2])", uiPos: CGPoint(x: 50, y: 50), fontColor: .yellow, size: 40.0)
        let score4txt = ui?.AddText(name: "txt-score4", text: "4. \(scoreList[3])", uiPos: CGPoint(x: 50, y: 45), fontColor: .yellow, size: 36.0)
        let score5txt = ui?.AddText(name: "txt-score5", text: "5. \(scoreList[4])", uiPos: CGPoint(x: 50, y: 40), fontColor: .yellow, size: 32.0)
        let score6txt = ui?.AddText(name: "txt-score6", text: "6. \(scoreList[5])", uiPos: CGPoint(x: 50, y: 35), fontColor: .yellow, size: 28.0)
        
        
        let textureButton = ui?.atlas.textureNamed("blue_button05")
        let menuBtn = ui?.AddButton(name: "btn-menu", tex: textureButton! , text: "MENU", uiPos: CGPoint(x: 50, y: 20), fontColor: .black, size: CGSize(width: 175, height: 75), closure: {
            self.toMainMenu(transition: SKTransition.doorsCloseHorizontal(withDuration: 0.75))
        })
        
        // storing these keys in case we need to access them later through the ui
        if let main = maintxt{
            uiElementNames.append(main)
        }
        if let score1 = score1txt {
            uiElementNames.append(score1)
        }
        if let score2 = score2txt {
            uiElementNames.append(score2)
        }
        if let score3 = score3txt {
            uiElementNames.append(score3)
        }
        if let score4 = score4txt {
            uiElementNames.append(score4)
        }
        if let score5 = score5txt {
            uiElementNames.append(score5)
        }
        if let score6 = score6txt {
            uiElementNames.append(score6)
        }
        if let menu = menuBtn {
            uiElementNames.append(menu)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        ui!.onTouchDown(point: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        // TODO: notify ui
        // TODO: notify game
    }
    
    func touchUp(atPoint pos : CGPoint) {
        ui!.onTouchUp(point: pos)
        // TODO: notify ui
        // TODO: notify game
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func loadScene(scene: SKScene, transition: SKTransition)
    {
        if let skView = view {
            shutdown()
            
            scene.scaleMode = .aspectFill
            scene.size = (view?.bounds.size)!
            scene.anchorPoint = .zero
            
            skView.presentScene(scene, transition: transition)
        }
    }
    
    func resetScene(transition: SKTransition)
    {
        loadScene(scene: self, transition: transition)
    }
    
    func toMainMenu(transition: SKTransition)
    {
        loadScene(scene: MainMenu.init(), transition: transition)
    }
    
    func shutdown() {
        removeAllActions()
        removeAllChildren()
    }
}
