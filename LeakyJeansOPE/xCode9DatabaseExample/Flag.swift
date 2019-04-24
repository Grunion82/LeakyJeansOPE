//
//  Flag.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 4/22/19.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit

class Flag {
    
    //Sprite for Flag loaded as a SKTexture
    let flagSprite = SKTexture(imageNamed: "Flag.png")
    
    //Sprite node to be added to the scene graph
    let flagSpriteNode = SKSpriteNode(imageNamed: "Flag.png")
    
    
    func InitializeAttributes(position: CGPoint) {
        
        flagSpriteNode.name = "Flag"
        flagSpriteNode.size = CGSize(width: 150, height: 150)
        flagSpriteNode.position = position
        flagSpriteNode.physicsBody = SKPhysicsBody(texture: flagSprite, size: flagSpriteNode.size)
        flagSpriteNode.physicsBody?.isDynamic = false
        flagSpriteNode.physicsBody?.categoryBitMask = CollisionTag.finish.rawValue
        flagSpriteNode.physicsBody?.collisionBitMask = 0
        flagSpriteNode.physicsBody?.contactTestBitMask = CollisionTag.player.rawValue
        
    }
    
}
