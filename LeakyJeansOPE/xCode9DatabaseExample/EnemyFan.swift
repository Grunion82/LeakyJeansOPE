//
//  EnemyFan.swift
//  xCode9DatabaseExample
//
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit

class Fan {
    
    //Sprite for Fan loaded as a SKTexture
    let fanSprite = SKTexture(imageNamed: "Fan.png")
    
    //Sprite node to be added to the scene graph
    let fanSpriteNode = SKSpriteNode(imageNamed: "Fan.png")
    var startNode: SKShapeNode =  SKShapeNode()
    var endNode: SKShapeNode = SKShapeNode()
    
    
    
    func InitializeAttributes(position: CGPoint) {
        fanSpriteNode.name = "Fan"
        fanSpriteNode.size = CGSize(width: 250, height: 75)
        fanSpriteNode.position = position
        fanSpriteNode.physicsBody = SKPhysicsBody(texture: fanSprite, size: fanSpriteNode.size)
        fanSpriteNode.physicsBody?.isDynamic = false
        fanSpriteNode.physicsBody?.categoryBitMask = CollisionTag.fan.rawValue
        fanSpriteNode.physicsBody?.collisionBitMask = CollisionTag.player.rawValue
        fanSpriteNode.physicsBody?.contactTestBitMask = CollisionTag.player.rawValue
        
    }
    
    
}
