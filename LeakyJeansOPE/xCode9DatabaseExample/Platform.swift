//
//  Platform.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 2019-04-15.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit

class Platform {
    
    //Sprite for Platform loaded as a SKTexture
    let platformSprite = SKTexture(imageNamed: "platform.png")
    
    //Sprite node to be added to the scene graph
    let platformSpriteNode = SKSpriteNode(imageNamed: "platform.png")

    
    func InitializeAttributes(position: CGPoint) {
        
        platformSpriteNode.name = "Platform"
        platformSpriteNode.size = CGSize(width: 250, height: 75)
        platformSpriteNode.position = position
        platformSpriteNode.physicsBody = SKPhysicsBody(texture: platformSprite, size: platformSpriteNode.size)
        platformSpriteNode.physicsBody?.isDynamic = false
        platformSpriteNode.physicsBody?.categoryBitMask = CollisionTag.platform.rawValue
        platformSpriteNode.physicsBody?.collisionBitMask = CollisionTag.player.rawValue
        platformSpriteNode.physicsBody?.contactTestBitMask = CollisionTag.player.rawValue
        
    }
    
    
}
