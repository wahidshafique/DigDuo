//
//  World.swift
//  Endian
//
//  Created by Derek Mallory on 2017-03-05.
//  Copyright © 2017 Derek Mallory. All rights reserved.
//

import GameKit
import SpriteKit

enum Layer: Int
{
    case none = -666
    case background = 0
    case middle
    case foreground
    case player
}

/*
 all entities must be associated with a world.
 the world houses the logic of the game
 */
class World: SKNode
{
//    var score: SKLabelNode
//    
    init(pixelsPerUnit: CGFloat)
    {
        PPU = pixelsPerUnit
        
        //score = SKLabelNode()
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
//    func start()
//    {
//            let screenDim = self.scene!.getDimensionsInScreen()
//        
//            self.physicsBody = SKPhysicsBody(rectangleOf: self.scene!.frame.size, center: CGPoint(x: screenDim.0/2, y: screenDim.1/2))
//            self.physicsBody?.isDynamic = false
//            self.physicsBody!.categoryBitMask = CollisionLayer.world.rawValue
//            self.physicsBody!.contactTestBitMask = CollisionLayer.enemy.rawValue | CollisionLayer.player.rawValue |
//                                              CollisionLayer.projectile.rawValue | CollisionLayer.level.rawValue
//        
//        score.fontSize = 32
//        score.fontColor = UIColor.green
//        score.blendMode = .replace
//        score.colorBlendFactor = 1.0
//        score.text = "SCORE: 0"
//        
//        score.zPosition = 999
//        score.position = CGPoint(x: screenDim.0-(0.75*screenDim.0), y: screenDim.1-(0.20*screenDim.1))
//        addChild(score)
//            
//            self.isStarted = true
//    }
//    
//    func update(_ deltaTime: TimeInterval)
//    {
//        if (!isPaused && isStarted)
//        {
//            checkInput()
//            
//            if !(player!.worldEntity.isAlive) {
//                gameOver()
//            }
//            
//            // update all objects in the world if appropriate
//            for worldObject in worldObjects {
//                let obj = worldObject.value
//                
//                if obj.isActive {
//                    sync(lock: obj as NSObject, closure: {
//                        obj.update(deltaTime)
//                    })
//                }
//            }
//            
//            // update score text
//            //score.text = "SCORE: \(Player.score)"
//        }
//    }
//    
//    func centerWorldObject(worldObject: WorldObject) {
//        if scene != nil {
//            let bounds = scene!.frame
//            worldObject.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
//        }
//    }
//    
//    private func checkInput()
//    {
//        let gameScene = scene as? GameScene
//        
//        // compare each touch input against the world
//        if gameScene != nil {
//            let input = gameScene?.pullInput()
//            
//            // player control input
//            for i in input! {
//                
//                let point = i.point
//                let type = i.type
//                
//                if type == .jump {
//                    player?.worldEntity.jump()
//                }
//                else if type == .other {
//                    for node in nodes(at: point!)
//                    {
//                        // if node is an entity...
//                        if node !== player!.worldEntity {
//                            
//                            // all entities are "controllables"
//                            if let controlled = node as? Controllable {
//                                let playerPos = player!.worldEntity.worldPosition
//                                let targetPos = controlled.worldPosition
//                                
//                                var directionVec: CGVector = .zero
//                                directionVec.dx = targetPos.x - playerPos.x
//                                directionVec.dy = targetPos.y - playerPos.y
//                                directionVec = directionVec.normalized
//                                
//                                player!.worldEntity.attack(direction: directionVec)
//                            }
//                            else if let controlled = node as? Projectile {
//                                let playerPos = player!.worldEntity.worldPosition
//                                let targetPos = controlled.worldPosition
//                                
//                                var directionVec: CGVector = .zero
//                                directionVec.dx = targetPos.x - playerPos.x
//                                directionVec.dy = targetPos.y - playerPos.y
//                                directionVec = directionVec.normalized
//                                
//                                player!.worldEntity.attack(direction: directionVec)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    func finish()
//    {
//        
//    }
//    
//    // collision
//    func collisionBegin(_ contact: SKPhysicsContact)
//    {
//        let a = contact.bodyA.node
//        let b = contact.bodyB.node
//        
//        if a === self || b === self {
//            let other = a !== self ? a : b
//            let worldCollOther = collisions[other!.physicsBody!]
//            let isAlreadyColliding = worldCollOther != nil ? worldCollOther! : false
//            if !isAlreadyColliding {                // override this
//                if worldCollOther == nil || worldCollOther == false {
//                    collisions[contact.bodyA] = true
//                }
//            }
//        }
//            // ensure both are world objects, otherwise discard
//        else if (a !== self && b !== self) {
//            if let objA = a as? WorldObject {
//                if let objB = b as? WorldObject {
//                    objA.collisionBegin(contact)
//                    objB.collisionBegin(contact)
//                }
//            }
//        }
//    }
//    
//    func collisionEnd(_ contact: SKPhysicsContact)
//    {
//        let a = contact.bodyA.node
//        let b = contact.bodyB.node
//        
//        if a === self || b === self {
//            if (a! is Projectile || b! is Projectile)
//                && (a! is World || b! is World)
//            {
//                print("Projectile")
//            }
//            
//            let other = a !== self ? a : b
//            let worldCollOther = collisions[other!.physicsBody!]
//            let isAlreadyColliding = worldCollOther != nil ? worldCollOther! : false
//            
//            if isAlreadyColliding {
//                // override this
//                if worldCollOther == true {
//                    collisions[contact.bodyA] = false
//                    
//                    if let worldObj = other as? WorldObject {
//                        if worldObj === player!.worldEntity {
//                            gameOver()
//                        }
//                        worldObj.destroy()
//                        print("Destroying: \(worldObj.worldID)")
//                    }
//                }
//            }
//        }
//        // ensure both are world objects, otherwise discard
//        else if (a !== self && b !== self) {
//            if let objA = a as? WorldObject {
//                if let objB = b as? WorldObject {
//                    objA.collisionEnd(contact)
//                    objB.collisionEnd(contact)
//                }
//            }
//        }
//    }
//    
//    func raycast(pointA: CGPoint, direction: CGVector, distance: CGFloat, collisionCheck: CollisionLayer) -> [WorldObject] {
//        
//        var endPoint = CGPoint()
//        endPoint.x = pointA.x+direction.dx*distance
//        endPoint.y = pointA.y+direction.dy*distance
//        
//        var worldObjList = [WorldObject]()
//        
//        scene?.physicsWorld.enumerateBodies(alongRayStart: pointA*PPU, end: endPoint*PPU, using: {
//            (body: SKPhysicsBody, point: CGPoint, normal: CGVector, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
//            
//            if let entity = (body.node!) as? WorldObject {
//                if (CollisionLayer.enemy.rawValue & collisionCheck.rawValue) > 0 {
//                    worldObjList.append(entity)
//                }
//                else if (CollisionLayer.player.rawValue & collisionCheck.rawValue) > 0 {
//                    worldObjList.append(entity)
//                }
//                else if (CollisionLayer.level.rawValue & collisionCheck.rawValue) > 0 {
//                    worldObjList.append(entity)
//                }
//                else if (CollisionLayer.projectile.rawValue & collisionCheck.rawValue) > 0 {
//                    worldObjList.append(entity)
//                }
//            }
//        })
//        
//        return worldObjList
//    }
//    
//    // initialization
//    func create()
//    {
//        createLayers()
//        createEntities()
//    }
//    
//    private func createLayers()
//    {
//        print("World: Initializing layers...")
//        
//        // background layer
//        var layer = SKNode()
//        layer.zPosition = CGFloat(Layer.background.rawValue)
//        addChild(layer)
//        layers.updateValue(layer, forKey: .background)
//        
//        // middle layer
//        layer = SKNode()
//        layer.zPosition = CGFloat(Layer.middle.rawValue)
//        addChild(layer)
//        layers.updateValue(layer, forKey: .middle)
//        
//        // foreground layer
//        layer = SKNode()
//        layer.zPosition = CGFloat(Layer.foreground.rawValue)
//        addChild(layer)
//        layers.updateValue(layer, forKey: .foreground)
//        
//        // player layer
//        layer = SKNode()
//        layer.zPosition = CGFloat(Layer.player.rawValue)
//        addChild(layer)
//        layers.updateValue(layer, forKey: .player)
//    }
//    
//    private func createEntities()
//    {
//        createPlayer()
//        run(.repeatForever(.sequence([.wait(forDuration: 3.0), .run({self.spawnEnemy()})])))
//        
//        let ground = RandomPlatform(associatedWorld: self, layer: Layer.middle)
//        ground.setRandomSurface(widthRange: .init(lowerLimit: 100, upperLimit: 100), height: 5, fillColor: .green, borderColor: .green)
//        ground.worldPosition = CGPoint(x: 0, y: 30)
//        ground.scrollSpeed = 30
//        ground.startScrolling()
//        
//        addObject(worldObject: ground)
//        
//        let platformProperties = PlatformProperties(widthRange: SKRange.init(lowerLimit: 20, upperLimit: 100), height: 5, fillColor: .gray, borderColor: .darkGray, scrollSpeed: 30)
//        let platformSpawner = PlatformSpawner(associatedWorld: self, layer: .foreground, platformProperties: platformProperties, spawnGap: SKRange(lowerLimit: 15, upperLimit: 20))
//        
//        addObject(worldObject: platformSpawner)
//        
//        platformSpawner.worldPosition = CGPoint(x: 100, y: 30.0)
//        
//        platformSpawner.startSpawning()
//    }
//    
//    
//    // all world objects have a unique id, so no risk of a collision
//    func addObject(worldObject: WorldObject)
//    {
//        if (!worldObjects.values.contains(worldObject))
//        {
//            worldObjects[worldObject.worldID] = worldObject
//            layers[worldObject.worldLayer]?.addChild(worldObject)
//        }
//    }
//    
//    // add a group of world objects to the world
//    func addObjects(list worldObjects: [WorldObject])
//    {
//        for worldObject in worldObjects {
//            if (!self.worldObjects.values.contains(worldObject))
//            {
//                self.worldObjects[worldObject.worldID] = worldObject
//                layers[worldObject.worldLayer]?.addChild(worldObject)
//            }
//        }
//    }
//    
//    private func spawnEnemy() {
//        let entityTex = SKTexture(imageNamed: "Idle__000")
//        let texSize = entityTex.size()
//        let entitySize = CGSize(width: texSize.width/PPU*0.20, height: texSize.height/PPU*0.20)
//        let entity = EntityObject(associatedWorld: self, worldLayer: .foreground, spriteTexture: entityTex, entitySize: entitySize, tintColor: .yellow)
//        
//        // ANIMATION
//        // idle animation
//        entity.animator.addAnimation(name: "idle", timePerFrame: 0.125, images: "Idle__000", "Idle__001", "Idle__002", "Idle__003", "Idle__004","Idle__005", "Idle__006", "Idle__007", "Idle__008","Idle__009")
//        // run animation
//        entity.animator.addAnimation(name: "run", timePerFrame: 0.0625, images: "Run__000", "Run__001", "Run__002", "Run__003", "Run__004","Run__005", "Run__006", "Run__007", "Run__008","Run__009")
//        // jump animation
//        entity.animator.addAnimation(name: "jump", timePerFrame: 0.03125, reversing: true,
//                                           images: "Jump__000", "Jump__001", "Jump__002", "Jump__003", "Jump__004","Jump__005", "Jump__006", "Jump__007", "Jump__008","Jump__009")
//        // attack animation
//        entity.animator.addAnimation(name: "attack", timePerFrame: 0.03125,
//                                           images: "Throw__000", "Throw__001", "Throw__002", "Throw__003", "Throw__004","Throw__005", "Throw__006", "Throw__007", "Throw__008","Throw__009")
//        entity.animator.addAnimation(name: "death", timePerFrame: 0.125,
//                                           images: "Dead__000", "Dead__001", "Dead__002", "Dead__003", "Dead__004","Dead__005", "Dead__006", "Dead__007", "Dead__008","Dead__009")
//        
//        entity.worldPosition = CGPoint(x: scene!.getDimensionsInScreen().0*(3.7/4)/PPU, y: 50)
//        // OTHER
//        entity.setConstraints(constraints: SKConstraint.zRotation(SKRange(constantValue: 0)))
//        entity.setState(.run, repeatingAnim: true, popState: true)
//        
//        entity.physicsBody?.categoryBitMask = CollisionLayer.enemy.rawValue
//        entity.physicsBody?.collisionBitMask = CollisionLayer.level.rawValue
//        entity.physicsBody?.contactTestBitMask = CollisionLayer.player.rawValue
//        
//        entity.jumpForce = 600
//        entity.projectileSpeed = 30
//        entity.velocity = Float(arc4random_uniform(10) + 5)
//        entity.lives = 1
//        
//        let controller = EnemyController(controlled: entity)
//        entity.enemyController = controller
//        
//        // player defaults to idle animation
//        addObject(worldObject: entity)
//    }
//
//    func createPlayer()
//    {
//        let playerTex = SKTexture(imageNamed: "Idle__000")
//        let texSize = playerTex.size()
//        let playerSize = CGSize(width: texSize.width/PPU*0.25, height: texSize.height/PPU*0.25)
//        let playerEntity = EntityObject(associatedWorld: self, worldLayer: Layer.player, spriteTexture: SKTexture(imageNamed: "Idle__000"), entitySize: playerSize, tintColor: .clear)
//        
//        // ANIMATION
//        // idle animation
//        playerEntity.animator.addAnimation(name: "idle", timePerFrame: 0.125, images: "Idle__000", "Idle__001", "Idle__002", "Idle__003", "Idle__004","Idle__005", "Idle__006", "Idle__007", "Idle__008","Idle__009")
//        // run animation
//        playerEntity.animator.addAnimation(name: "run", timePerFrame: 0.0625, images: "Run__000", "Run__001", "Run__002", "Run__003", "Run__004","Run__005", "Run__006", "Run__007", "Run__008","Run__009")
//        // jump animation
//        playerEntity.animator.addAnimation(name: "jump", timePerFrame: 0.03125, reversing: true,
//                                           images: "Jump__000", "Jump__001", "Jump__002", "Jump__003", "Jump__004","Jump__005", "Jump__006", "Jump__007", "Jump__008","Jump__009")
//        // attack animation
//        playerEntity.animator.addAnimation(name: "attack", timePerFrame: 0.03125,
//                                           images: "Throw__000", "Throw__001", "Throw__002", "Throw__003", "Throw__004","Throw__005", "Throw__006", "Throw__007", "Throw__008","Throw__009")
//        playerEntity.animator.addAnimation(name: "death", timePerFrame: 0.125,
//                                           images: "Dead__000", "Dead__001", "Dead__002", "Dead__003", "Dead__004","Dead__005", "Dead__006", "Dead__007", "Dead__008","Dead__009")
//        
//        // OTHER
//        playerEntity.setConstraints(constraints: SKConstraint.zRotation(SKRange(constantValue: 0)), SKConstraint.positionX(SKRange(lowerLimit: -5.0, upperLimit: scene!.getDimensionsInScreen().0/2.0)))
//        playerEntity.setState(.run, repeatingAnim: true, popState: true)
//        
//        playerEntity.physicsBody?.categoryBitMask = CollisionLayer.player.rawValue
//        playerEntity.physicsBody?.collisionBitMask = CollisionLayer.level.rawValue
//        playerEntity.physicsBody?.contactTestBitMask = CollisionLayer.enemy.rawValue
//        
//        centerWorldObject(worldObject: playerEntity)
//        
//        var pos = playerEntity.worldPosition
//        pos.x -= 20
//        pos.y = 100
//        
//        playerEntity.worldPosition = pos
//        
//        playerEntity.jumpForce = 750
//        playerEntity.projectileSpeed = 65
//        playerEntity.attackDelay = 0.3
//        playerEntity.lives = 999
//        
//        // player defaults to idle animation
//        player = Player(worldEntity: playerEntity)
//        addObject(worldObject: playerEntity)
//        playerEntity.worldPosition = CGPoint(x: playerEntity.worldPosition.x, y: 150.0)
//        
//        Player.score = 0
//    }
//    
//    func destroyPlayer()
//    {
//        destroyObject(worldID: player!.worldEntityID)
//        player = nil
//    }
//    
//    func destroyObject(worldID: WorldObjectID)
//    {
//        let entityFound = worldObjects.keys.contains(worldID)
//        
//        if (entityFound)
//        {
//            if worldObjects[worldID]! !== player?.worldEntity {
//                Player.score += 1
//            }
//            
//            worldObjects[worldID]?.removeFromParent()            
//            worldObjects.removeValue(forKey: worldID)
//        }
//    }
//    
//    // tear down the wall
//    func destroy()
//    {
//        print("Goodbye cruel world...")
//        scene?.removeAllActions()
//        scene?.removeAllChildren()
//        isStarted = false
//    }
//
//    // world translation
//    func worldToPixelPoint(worldPoint: CGVector) -> CGVector {
//        return CGVector(dx: worldPoint.dx*PPU, dy: worldPoint.dy*PPU)
//    }
//    
//    func pixelToWorldPoint(pixelPoint: CGVector) -> CGVector {
//        return CGVector(dx: pixelPoint.dx*PPU, dy: pixelPoint.dy*PPU)
//    }
//    
//    func getWorldBounds() -> CGRect? {
//        let worldDim = scene?.getDimensionsInWorldUnits(ppu: (PPU, PPU))
//        var bounds: CGRect? = nil
//        
//        if worldDim != nil {
//            let worldWidth = CGFloat(worldDim!.0)
//            let worldHeight = CGFloat(worldDim!.1)
//            
//            bounds = CGRect(x: worldWidth/2, y: worldHeight/2, width: worldWidth, height: worldHeight)
//        }
//        
//        return bounds
//    }
//    
//    func gameOver() {
//        if let scn = (scene) as? IEndianScene {
//            scn.loadScene(sceneNamed: "GameMenu")
//        }
//    }
//        
//    // fields
//    private var worldObjects = [WorldObjectID:WorldObject]()
//    private var layers = [Layer : SKNode]()
//    private var isStarted = false
    internal let PPU: CGFloat // pixels per world unit
//    private var collisions: [SKPhysicsBody:Bool] = [:]
//    
//    // PROPERTIES
//    var started: Bool {
//        return isStarted
//    }
//    
    var pixelsPerWorldUnit: CGFloat {
        return PPU
    }
//
//    var player: Player?
}
