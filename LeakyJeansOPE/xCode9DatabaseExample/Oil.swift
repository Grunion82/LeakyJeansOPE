//
//  Oil.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 4/22/19.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit

class Oil {
    
    //Sprite for Oil loaded as a SKTexture
    let oilSprite = SKTexture(imageNamed: "Oil.png")
    
    //Sprite node to be added to the scene graph
    let oilSpriteNode = SKSpriteNode(imageNamed: "Oil.png")
    
    
    func InitializeAttributes(position: CGPoint) {
        
        oilSpriteNode.name = "Oil"
        oilSpriteNode.size = CGSize(width: 60, height: 30)
        oilSpriteNode.position = position
        oilSpriteNode.physicsBody = SKPhysicsBody(texture: oilSprite, size: oilSpriteNode.size)
        oilSpriteNode.physicsBody?.isDynamic = false
        oilSpriteNode.physicsBody?.categoryBitMask = CollisionTag.oil.rawValue
        oilSpriteNode.physicsBody?.collisionBitMask = 0
        oilSpriteNode.physicsBody?.contactTestBitMask = CollisionTag.player.rawValue
        
    }
    
}
