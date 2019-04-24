//
//  WaterToken.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 4/22/19.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit

class WaterToken {
    
    //Sprite for WaterDrop loaded as a SKTexture
    let waterTokenSprite = SKTexture(imageNamed: "WaterDrop.png")
    
    //Sprite node to be added to the scene graph
    let waterTokenSpriteNode = SKSpriteNode(imageNamed: "WaterDrop.png")
    
    
    func InitializeAttributes(position: CGPoint) {
        
        waterTokenSpriteNode.name = "Water"
        waterTokenSpriteNode.size = CGSize(width: 40, height: 40)
        waterTokenSpriteNode.position = position
        waterTokenSpriteNode.physicsBody = SKPhysicsBody(texture: waterTokenSprite, size: waterTokenSpriteNode.size)
        waterTokenSpriteNode.physicsBody?.isDynamic = false
        waterTokenSpriteNode.physicsBody?.categoryBitMask = CollisionTag.water.rawValue
        waterTokenSpriteNode.physicsBody?.collisionBitMask = 0
        waterTokenSpriteNode.physicsBody?.contactTestBitMask = CollisionTag.player.rawValue
        
    }
    
}
