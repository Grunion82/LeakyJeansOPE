//
//  Jeans.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 2019-04-11.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit

class Jeans {
    
    //Sprite for Jeans loaded as a SKTexture
    let jeansSprite = SKTexture(imageNamed: "JeanSprite1.png")
    
    //Sprite node to be added to scene graph
    let jeansSpriteNode = SKSpriteNode(imageNamed: "JeanSprite1.png")
    
    //Starting position for the Jeans
    let startPos: CGPoint = CGPoint(x: 0, y: 50)
    
    //The max water level of the jeans
    let MAX_WATER_LEVEL: CGFloat = 100.0
    
    //Holds how wet the jeans are
    var wetness: CGFloat = 100.0
    
    //Holds what level of oil is taking up the Jeans
    var oilLevel: CGFloat = 0.0
    
    //The max speed of the Jeans
    let MAX_SPEED: CGFloat = 10.0
    
    //Holds how fast the jeans move
    var speed: CGFloat = 5.0
    
    //Holds how fast the Jeans will leak when moving
    var leakLevel: CGFloat = 0.15
    
    //Keeps track of if the Jeans should be moving left
    var moveLeft = false
    //Keeps track of if the Jeans should be moving right
    var moveRight = false
    //Can only jump if set to true
    var isGrounded = true
    
    func InitializeAttributes() {
        
        jeansSpriteNode.name = "Player"
        jeansSpriteNode.size = CGSize(width: 75, height: 100)
        jeansSpriteNode.position = startPos
        let newConstraints: NSArray = [SKConstraint.zRotation(SKRange(lowerLimit: 0, upperLimit: 0))]
        jeansSpriteNode.constraints = (newConstraints as! [SKConstraint])
        jeansSpriteNode.physicsBody = SKPhysicsBody(texture: jeansSprite, size: jeansSpriteNode.size)
        jeansSpriteNode.physicsBody?.categoryBitMask = CollisionTag.player.rawValue
        jeansSpriteNode.physicsBody?.collisionBitMask = CollisionTag.platform.rawValue
        jeansSpriteNode.physicsBody?.contactTestBitMask = CollisionTag.platform.rawValue | CollisionTag.spike.rawValue | CollisionTag.oil.rawValue | CollisionTag.water.rawValue
        
        //Frame stuff
        
    }
    
    func UpdatePosition() {
        
        speed = MAX_SPEED - (wetness / 20.0)
        
        //Moves player left
        if(moveLeft == true) {
            jeansSpriteNode.position.x += -speed
            wetness -= leakLevel
        }
        //Moves player right
        if(moveRight == true) {
            jeansSpriteNode.position.x += speed
            wetness -= leakLevel
        }
        //Reset player position if passed a certain threshold
        if(jeansSpriteNode.position.y < -350) {
            jeansSpriteNode.position = startPos
            wetness -= 15.0
        }
        
        //Clamp wetness to above 0 and below its Max
        if(wetness < 0.0) {
            wetness = 0.0
        }
        if(oilLevel > MAX_WATER_LEVEL) {
            oilLevel = MAX_WATER_LEVEL
        }
        if(wetness > MAX_WATER_LEVEL - oilLevel) {
            wetness = MAX_WATER_LEVEL - oilLevel
        }
        
    }
    
    func Jump() {
        
        if(isGrounded == true) {
            jeansSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
            isGrounded = false
        }
        
    }
}
