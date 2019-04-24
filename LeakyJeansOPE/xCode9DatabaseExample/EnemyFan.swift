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
    let fanSprite = SKTexture(imageNamed: "fan000.png")
    
    //Sprite node to be added to the scene graph
    let fanSpriteNode = SKSpriteNode(imageNamed: "fan000.png")
    var startNode: SKShapeNode =  SKShapeNode()
    var endNode: SKShapeNode = SKShapeNode()
    var movingLeft: Bool = true
    var damageBox: SKShapeNode = SKShapeNode()
    
    var speed: CGFloat = 5.0
    
    func InitializeAttributes(position: CGPoint) {
        fanSpriteNode.name = "Fan"
        fanSpriteNode.size = CGSize(width: 80, height: 80)
        fanSpriteNode.position = position
        fanSpriteNode.physicsBody = SKPhysicsBody(texture: fanSprite, size: fanSpriteNode.size)
        fanSpriteNode.physicsBody?.isDynamic = true
        fanSpriteNode.physicsBody?.categoryBitMask = CollisionTag.fan.rawValue
        fanSpriteNode.physicsBody?.collisionBitMask = CollisionTag.player.rawValue | CollisionTag.platform.rawValue
        fanSpriteNode.physicsBody?.contactTestBitMask = CollisionTag.player.rawValue | CollisionTag.platform.rawValue
        
        startNode.position.x = position.x - 70
        startNode.position.y = position.y
        startNode.fillColor = .red
        startNode.physicsBody?.isDynamic = false
        
        endNode.position.x = position.x + 70
        endNode.position.y = position.y
        endNode.fillColor = .blue
        endNode.physicsBody?.isDynamic = false
        
        //damageBox = SKShapeNode(rect: CGRect(x: position.x - 10, y: position.y, width: 40, height: 20))
        //fanSpriteNode.physicsBody?.categoryBitMask = CollisionTag.fan.rawValue
        //damageBox.physicsBody?.contactTestBitMask = CollisionTag.player.rawValue
    }
    
    func UpdatePosition(){
        if(fanSpriteNode.position.x == startNode.position.x || fanSpriteNode.position.x < startNode.position.x){
            movingLeft = false
        }
        else if(fanSpriteNode.position.x == endNode.position.x || fanSpriteNode.position.x > endNode.position.x){
            movingLeft = true
        }
        
        if(movingLeft && fanSpriteNode.position.x > startNode.position.x){
            fanSpriteNode.position.x -= speed
            damageBox.position.x -= speed
        }
        else if(!movingLeft && fanSpriteNode.position.x < endNode.position.x){
            fanSpriteNode.position.x += speed
            damageBox.position.x += speed
        }
        
    }
    
    
}
