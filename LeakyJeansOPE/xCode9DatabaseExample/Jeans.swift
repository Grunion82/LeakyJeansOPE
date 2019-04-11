//
//  Jeans.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 2019-04-11.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit

class Jeans : SKSpriteNode {
    
    //Sprite for Jeans loaded as a SKTexture
    let jeansSprite = SKTexture(imageNamed: "JeanSprite1.png")
    
    //Keeps track of if the Jeans should be moving left
    var moveLeft = false
    //Keeps track of if the Jeans should be moving right
    var moveRight = false
    
    func InitializeAttributes() {
        
        size = CGSize(width: 75, height: 100)
        position = CGPoint(x: 0, y: 50)
        let newConstraints: NSArray = [SKConstraint.zRotation(SKRange(lowerLimit: 0, upperLimit: 0))]
        constraints = (newConstraints as! [SKConstraint])
        physicsBody = SKPhysicsBody(texture: jeansSprite, size: self.size)
        
        //Frame stuff
        
    }
    
    func UpdatePosition() {
        
        //Moves player left
        if(moveLeft == true) {
            position.x += -4.0
        }
        //Moves player right
        if(moveRight == true) {
            position.x += 4.0
        }
        
    }
}
