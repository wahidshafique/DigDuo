//
//  Entity.swift
//  Endian
//
//  Created by Derek Mallory on 2017-03-05.
//  Copyright © 2017 Derek Mallory. All rights reserved.
//

import GameKit
import SpriteKit

typealias WorldObjectID = UInt

enum WorldObjectType
{
    case empty
    case entity
    case interactable
    case level
}

enum CollisionLayer: UInt32 {
    case none = 0, world = 2, level = 4, projectile = 8, player = 16, enemy = 32
}

/*
 Base any in game world nodes off of this entity.
 */
class WorldObject : SKNode
{
    init(associatedWorld world: World, layer: Layer?)
    {
        self.world = world
        
        // set the world id of the worldobject (starts from 1)
        WorldObject.currentWorldID += 1
        self.id = WorldObject.currentWorldID
        self.layer = layer != nil ? layer! : .foreground

        super.init()
        
        self.zPosition = CGFloat.init(self.layer.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(constraints: SKConstraint...)
    {
        self.constraints = constraints
    }
    
    // perform an action after a certain delay,
    // then destroy the object
    func destroy(delay: Float? = nil, action: SKAction, targetOfAction: SKNode)
    {
        if delay != nil && delay! > 0 {
            self.run(SKAction.wait(forDuration: TimeInterval(delay!)))
            {
                targetOfAction.run(action){
                    //self.world.destroyObject(worldID: self.id)
                }
            }
        }
        else
        {
            targetOfAction.run(action){
                //self.world.destroyObject(worldID: self.id)
            }
        }
    }
    // destroy the object in "destroyTime"
    func destroy() {
        run(.wait(forDuration: destroyTime)){
            //self.world.destroyObject(worldID: self.worldID)
        }
    }
    
    // override this function if you need it
    // only gets called if object is "active"
    func update(_ deltaTime: TimeInterval) {
        // update stuff goes here : )
    }
    
    // collision
    func collisionBegin(_ contact: SKPhysicsContact)
    {
        // override this
        if contact.bodyA != physicsBody && collisions[contact.bodyA] == nil {
            collisions[contact.bodyA] = true
        }
        else if contact.bodyB != physicsBody && collisions[contact.bodyB] == nil {
            collisions[contact.bodyB] = true
        }
    }
    
    func collisionEnd(_ contact: SKPhysicsContact)
    {
        // override this
        if contact.bodyA != physicsBody && collisions[contact.bodyA] != nil {
            collisions[contact.bodyA] = false
        }
        else if contact.bodyB != physicsBody && collisions[contact.bodyB] != nil {
            collisions[contact.bodyB] = false
        }
    }
    
    func collidingWith(body: SKPhysicsBody) -> Bool {
        return physicsBody != nil ? physicsBody!.allContactedBodies().contains(body) : false
    }
    
    // FIELDS
    internal var type: WorldObjectType = .empty
    private var id : WorldObjectID
    private var layer: Layer
    internal unowned var world: World
    
    var destroyOnExitBounds: Bool = true
    
    var destroyTime: Double = 0.0 // amount of time it takes to destroy this object once destroy is called
    
    internal var collisions = [SKPhysicsBody:Bool]()
    
    // PROPERTIES
//    subscript(collidingWith: SKPhysicsBody) -> Bool {
//        return physicsBody != nil ? physicsBody!.allContactedBodies().contains(collidingWith) : false
//    }
    
    var worldID : WorldObjectID {
        return id
    }
    
    var worldLayer: Layer {
        return self.layer
    }
    
    var worldType: WorldObjectType {
        return self.type
    }
    
    var worldPosition: CGPoint {
        get {
            return CGPoint(x: position.x/world.PPU, y: position.y/world.PPU)
        }
        set (value) {
            let newPoint = CGPoint(x: value.x*world.PPU, y: value.y*world.PPU)
            position = newPoint
        }
    }
    
    // use this property to determine if this object will
    var isActive: Bool {
        get { return !isHidden }
        set (value) { isHidden = value; }
    }
    
    var worldSize: CGSize {
        let realSize = calculateAccumulatedFrame().size
        
        let worldWidth = realSize.width / world.PPU
        let worldHeight = realSize.height / world.PPU
        
        return CGSize(width: worldWidth, height: worldHeight)
    }
    
    // STATIC FIELDS
    private static var currentWorldID : WorldObjectID = 0
}

extension WorldObject
{
    func log(_ msg: String)
    {
        print("WorldObject \(self.worldID): " + msg)
    }
}
