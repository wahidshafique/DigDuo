//
//  Animator.swift
//  Endian
//
//  Created by Derek Mallory on 2017-03-06.
//  Copyright © 2017 Derek Mallory. All rights reserved.
//

import SpriteKit
import GameKit

class Animator
{
    init(animatedObject: Animatable)
    {
        self.animatedObject = animatedObject
    }
    
    fileprivate struct Animation : Hashable
    {
        /*
         Note: If restoreFrame is set to false, 
         you have taken responsibility for having to clear the animation
         ie. "stopAnimation()"
        */
        init(textures: [SKTexture], timePerFrame: TimeInterval,
             name: String, restoreFrame: Bool = false, reversing: Bool = false)
        {
            var texToAdd = textures
            if (reversing)
            {
                texToAdd.append(contentsOf: textures.reversed())
            }
            
            action = .animate(with: texToAdd, timePerFrame: timePerFrame, resize: restoreFrame, restore: true)
            self.name = name
            holdingEndFrame = restoreFrame
            self.reversing = reversing
        }
        
        let action: SKAction
        let name: String
        let holdingEndFrame: Bool
        let reversing: Bool
        
        public var hashValue: Int { return name.hashValue }
        
        static func ==(lhs: Animation, rhs: Animation) -> Bool
        {
            return lhs.name.hashValue == rhs.name.hashValue
        }
    }
    
    /*
     create and add a new animation
     reversing the animation when done makes it appear less choppy
     */
    func addAnimation(name: String, timePerFrame: TimeInterval,
                      holdLastFrame: Bool = false, reversing: Bool = false, images named: String...)
    {
        // create the animation if there is none referenced by the wanted name
        if !animations.keys.contains(name)
        {
            var textureList = [SKTexture]()
            
            // append the textures to the list
            for name in named
            {
                let texture = SKTexture(imageNamed: name)
                
                textureList.append(texture)
            }
            
            // initialize the animation
            let animation = Animation.init(textures: textureList, timePerFrame: timePerFrame, name: name, restoreFrame: holdLastFrame, reversing: reversing)
            animations[name] = animation
        }
        else
        {
            print("Animator: Already contains animation '\(name)'")
        }
    }
    /*
     create and add a new animation
     reversing the animation when done makes it appear less choppy
    */
    func addAnimation(name: String, timePerFrame: TimeInterval,
                      reversing: Bool = false, holdLastFrame: Bool = false, images textures: SKTexture...)
    {
        // create the animation if there is none referenced by the wanted name
        if !animations.keys.contains(name)
        {
            var textureList = [SKTexture]()
            
            // append the textures to the list
            for texture in textures
            {
                textureList.append(texture)
            }
            
            // initialize the animation
            let animation = Animation.init(textures: textureList, timePerFrame: timePerFrame, name: name, restoreFrame: holdLastFrame, reversing: reversing)
            animations[name] = animation
        }
        else
        {
            print("Animator: Already contains animation by the name \(name).")
        }
    }
    
    
    func pauseAnimation() {
        if let anim = sprite.action(forKey: runningAnim)
        {
            anim.speed = 0.0
        }
    }
    
    func unpauseAnimation() {
        if let anim = sprite.action(forKey: runningAnim)
        {
            anim.speed = 1.0
        }
    }
    
    fileprivate func pauseAnimation(anim: Animation)
    {
        let anim = sprite.action(forKey: anim.name)
        
        if anim != nil
        {
            anim!.speed = 0.0
        }
    }
    
    fileprivate func unpauseAnimation(anim: Animation)
    {
        let anim = sprite.action(forKey: anim.name)
        
        if anim != nil
        {
            anim!.speed = 1.0
        }
    }
    
    // start an animation that has been initialized already.
    // will pop the current animation if specified.
    // animations are unique in the list, so this new animation will overwrite any previous instances
    func startAnimation(anim key: String, repeating loop: Bool, popCurrent: Bool = false)
    {
        if animations.keys.contains(key) && !isAnimationRunning(anim: key)
        {
            let anim = animations[key]
            
            let runningAnimCount = runningAnimations.count
            
            if popCurrent
            {
                stopAnimation(anim: runningAnim)
            }
            else if (runningAnimCount > 0)
            {
                // pause the current animation
                pauseAnimation(anim: runningAnimations[runningAnimCount-1])
            }
            
            // set the animation on top of the "stack" and to be the current
            // running animation
            runningAnimations.append(anim!)
            
            if loop
            {
                sprite.run(SKAction.repeatForever((anim?.action)!), withKey: key)
            }
            else {
                // the default is to clear the animation and signal the animatable object when completed
                if !(anim?.holdingEndFrame)!
                {
                    let completion = {
                        let index = self.getAnimationRunningIndex(anim: anim!.name)
                        
                        self.runningAnimations.remove(at: index)
                        
                        let runningAnimCount = self.runningAnimations.count
                        
                        if runningAnimCount > 0
                        {
                            self.unpauseAnimation(anim: self.runningAnimations[runningAnimCount-1])
                        }
                        
                        // thread safe : 3
                        sync(lock: self.animatedObject as! NSObject, closure: {
                            self.animatedObject.animationComplete(animationName: key)
                        })
                    }
                    
                    sprite.run(.sequence([(anim?.action)!, .run(completion)]), withKey: key)
                }
                // else it is the responsibility of the programmer to release the animation
                // ie. "stopAnimation()"
                else
                {
                    sprite.run((anim?.action)!)
                }
            }
        }
        else
        {
            print("Animator: Could not start animation \(key)")
        }
    }
    
    // stop the current animation and go back to the one previous
    func stopAnimation(anim key: String, notifyAnimatedObject: Bool = true)
    {
        let runningIndex = getAnimationRunningIndex(anim: key)
        
        if runningIndex >= 0
        {
            let runningAnim = runningAnimations[runningIndex]
            
            if (notifyAnimatedObject)
            {
                sync(lock: animatedObject as! NSObject, closure: {
                    animatedObject.animationComplete(animationName: key)
                })
            }
            
            sprite.removeAction(forKey: runningAnim.name)
            runningAnimations.remove(at: runningIndex)
            
            let runningAnimCount = self.runningAnimations.count
            
            if runningAnimCount > 0
            {
                self.unpauseAnimation(anim: self.runningAnimations[runningAnimCount-1])
            }
        }
    }
    
    // clear the stack of animations
    func stopAnimations()
    {
        for animation in runningAnimations
        {
            sprite.removeAction(forKey: animation.name)
        }
        runningAnimations.removeAll()
    }
    
    // check if an animation is running
    func isAnimationRunning(anim key: String) -> Bool
    {
        let anim = runningAnimations.filter {
            return $0.name == key
        }
        
        return anim.count > 0
    }
    
    // get the animation index if it's on the "running stack"
    fileprivate func getAnimationRunningIndex(anim key: String) -> Int
    {
        for i in 0..<runningAnimations.count
        {
            if runningAnimations[i].name == key
            {
                return i
            }
        }
        
        return -1
    }
    
    private var animations = [String : Animation]()
    private var runningAnimations = [Animation]()   // treated like a stack
    private unowned var animatedObject : Animatable
    
    private var sprite: SKSpriteNode {
        return animatedObject.sprite
    }
    
    var runningAnim: String {
        let animCount = runningAnimations.count
        
        return animCount>0 ? runningAnimations[animCount-1].name
                : "none"
    }
}
