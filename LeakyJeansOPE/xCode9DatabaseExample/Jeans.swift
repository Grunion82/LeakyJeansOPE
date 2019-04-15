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
    
    //Keeps track of if the Jeans should be moving left
    var moveLeft = false
    //Keeps track of if the Jeans should be moving right
    var moveRight = false
    
    func InitializeAttributes() {
        
        jeansSpriteNode.size = CGSize(width: 75, height: 100)
        jeansSpriteNode.position = CGPoint(x: 0, y: 50)
        let newConstraints: NSArray = [SKConstraint.zRotation(SKRange(lowerLimit: 0, upperLimit: 0))]
        jeansSpriteNode.constraints = (newConstraints as! [SKConstraint])
        jeansSpriteNode.physicsBody = SKPhysicsBody(texture: jeansSprite, size: jeansSpriteNode.size)
        
        //Frame stuff
        
    }
    
    func UpdatePosition() {
        
        //Moves player left
        if(moveLeft == true) {
            jeansSpriteNode.position.x += -4.0
        }
        //Moves player right
        if(moveRight == true) {
            jeansSpriteNode.position.x += 4.0
        }
        
    }
}
