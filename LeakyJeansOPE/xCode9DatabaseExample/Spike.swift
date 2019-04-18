//
//  Spike.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 4/18/19.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit

class Spike {
    
    //Sprite for Spike loaded as a SKTexture
    let spikeSprite = SKTexture(imageNamed: "Spike.png")
    
    //Sprite node to be added to the scene graph
    let spikeSpriteNode = SKSpriteNode(imageNamed: "Spike.png")
    
    
    func InitializeAttributes(position: CGPoint) {
        
        spikeSpriteNode.name = "Spike"
        spikeSpriteNode.size = CGSize(width: 30, height: 30)
        spikeSpriteNode.position = position
        spikeSpriteNode.physicsBody = SKPhysicsBody(texture: spikeSprite, size: spikeSpriteNode.size)
        spikeSpriteNode.physicsBody?.isDynamic = false
        spikeSpriteNode.physicsBody?.categoryBitMask = CollisionTag.spike.rawValue
        spikeSpriteNode.physicsBody?.collisionBitMask = 0
        spikeSpriteNode.physicsBody?.contactTestBitMask = CollisionTag.player.rawValue
        
    }
    
    
    
}
