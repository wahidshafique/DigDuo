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
    func start()
    {
    }
    
    func update(_ deltaTime: TimeInterval)
    {
    }
    
    func centerWorldObject(worldObject: WorldObject) {
        if scene != nil {
            let bounds = scene!.frame
            worldObject.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        }
    }
    

    
    func finish()
    {
        
    }
    

    
    // initialization
    func create()
    {
    }

    func createPlayer()
    {
       
    }
    
    func destroyObject(worldID: WorldObjectID)
    {
       
    }
    
    // tear down the wall
    func destroy()
    {
    }


    
    func gameOver() {
        
    }
        
    // fields
    private var worldObjects = [WorldObjectID:WorldObject]()
    private var layers = [Layer : SKNode]()
    private var isStarted = false
    
    //region GetSmart
    //    func raycast(pointA: CGPoint, direction: CGVector, distance: CGFloat, collisionCheck: CollisionLayer) -> [WorldObject] {
    //
    //        var endPoint = CGPoint()
    //        endPoint.x = pointA.x+direction.dx*distance
    //        endPoint.y = pointA.y+direction.dy*distance
    //
    //        var worldObjList = [WorldObject]()
    //
    
    //        scene?.physicsWorld.enumerateBodies(alongRayStart: pointA*Globals.pixelsPerUnit, end: endPoint*Globals.pixelsPerUnit, using: {
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
    
//    // PROPERTIES
//    var started: Bool {
//        return isStarted
//    }
//
//
//    var player: Player?
}
