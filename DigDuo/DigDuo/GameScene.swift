//
//  MainMenu.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None:    UInt32 = 0
    static let Mole:   UInt32 = 0b1
    static let Enemy:  UInt32 = 0b10
    static let Collectable:    UInt32 = 0b100
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    //TODO temp, abstract it later
    private var playerAnim: Animator?
    //private var player :Player?
    private var player: PlayerEntity?
    
    private var cam: SKCameraNode?
    private var ui : UserInterface?
    private var uiElementNames = [String]()
    
    public var background: SKSpriteNode?
    private var npc: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.name = "Main Scene"
        super.didMove(to: view)
        self.backgroundColor = UIColor.brown
        let dimensions = getDimensionsInScreen()
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"), color: .white, size: CGSize(width: 1920, height: 4320))
        background?.blendMode = .replace
        background?.zPosition = 0
        background?.colorBlendFactor = 1.0
        addChild(background!)
        //background!.position += CGVector(dx: dimensions.width/4.0, dy: dimensions.height/2.0)
        
        //addChild(ui!)
        createPlayer(point: CGPoint(x: 0, y: 0))
        //animatePlayer(sprite: (player?.component(ofType: VisualComponent.self)?.sprite)!)
        cameraSpawn()
    }
    
    func createPlayer(point: CGPoint) {
        player = PlayerEntity(pos: CGPoint(x: point.x, y: point.y))
        //create sprite
        let texture = SKTexture(imageNamed: "Player")
        let playerSprite = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        playerSprite.yScale = (playerSprite.yScale) * -1
        playerSprite.position = point
        
        let radius = CGFloat(playerSprite.size.width / 2)
        let boundary = SKShapeNode(circleOfRadius: radius)
        boundary.strokeColor = UIColor.gray
        playerSprite.addChild(boundary)
        
        // add physics properties
        playerSprite.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        playerSprite.physicsBody!.isDynamic = false
        
        let visComp = VisualComponent(scene: self, sprite: playerSprite)
        player?.addComponent(visComp)
    
        player?.addComponent(MoveComponent(scene:self, sprite: playerSprite))
        
        //Not working as a component for some reason
        //let camComp = CameraComponent(scene: self, sprite: playerSprite)
        //player?.addComponent(camComp)
    }

    func cameraSpawn() {
        let p = player?.component(ofType: VisualComponent.self)?.sprite
        //todo, migrate to world..
        cam = SKCameraNode()
        self.camera = cam
        camera?.setScale(2.0)
        
        ui = UserInterface(size: CGSize(width: (cam?.frame.size.width)!, height: (cam?.frame.size.height)!))
        let scoreTxt = ui?.AddText(name: "txt-score", text: "Score: 000", uiPos: CGPoint(x: 0, y: 0), fontColor: .yellow, size: 25.0)
        let pauseButton = ui?.AddButton(name: "btn-pause", imageNamed: "pause", text: "", uiPos: CGPoint(x: 0, y: 0), fontColor: .clear, size: CGSize(width: 60, height: 60), closure: {
            self.loadScene(scene: GameoverScene.init(), transition: SKTransition.crossFade(withDuration: 0.35))
        })
        
        // storing these keys in case we need to access them later through the ui
        if let score = scoreTxt{
            uiElementNames.append(score)
        }
        if let pause = pauseButton {
            uiElementNames.append(pause)
        }
        
        cam?.addChild(ui!)
        
        // Constrain the camera to stay a constant distance of 0 points from the player node.
        let zeroRange = SKRange(constantValue: 0.0)
        let playerLocationConstraint = SKConstraint.distance(zeroRange, to: p!)
        
        // get the scene size as scaled by `scaleMode = .AspectFill`
        let scaledSize = CGSize(width: size.width * (camera?.xScale)!, height: size.height * (camera?.yScale)!)
        
        // get the frame of the entire level contents
        let boardNode = background
        let boardContentRect = boardNode?.calculateAccumulatedFrame()
        
        // inset that frame from the edges of the level
        // inset by `scaledSize / 2 - 100` to show 100 pt of black around the level
        // (no need for `- 100` if you want zero padding)
        // use min() to make sure we don't inset too far if the level is small
        let xInset = min((scaledSize.width / 2), (boardContentRect?.width)! / 2)
        let yInset = min((scaledSize.height / 2) + 100.0, (boardContentRect?.height)! - (boardNode?.size.height)!)
        let insetContentRect = boardContentRect?.insetBy(dx: xInset, dy: yInset)
        
        // use the corners of the inset as the X and Y range of a position constraint
        let xRange = SKRange(lowerLimit: (insetContentRect?.minX)!, upperLimit: (insetContentRect?.maxX)!)
        let yRange = SKRange(lowerLimit: (insetContentRect?.minY)!, upperLimit: (insetContentRect?.maxY)!)
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        levelEdgeConstraint.referenceNode = boardNode
        
        
        cam?.constraints = [playerLocationConstraint, levelEdgeConstraint]
        self.addChild(cam!)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        player?.component(ofType: MoveComponent.self)?.moveToPoint(pos, duration: 1)
        
        ui!.onTouchDown(point: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        player?.component(ofType: MoveComponent.self)?.moveToPoint(pos, duration: 1)
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
        super.update(currentTime)
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
    
    func resetScene()
    {
        loadScene(scene: self, transition: SKTransition.crossFade(withDuration: 0.25))
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
