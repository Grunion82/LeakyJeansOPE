//
//  LevelOne.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 3/29/19.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import UIKit
import GameKit
import SpriteKit

class LevelOne: SKScene {
    
    let playerJeans = SKSpriteNode(imageNamed: "JeanSprite1.png")
        
        override func didMove(to view: SKView) {
            
            addChild(playerJeans)
            playerJeans.size = CGSize(width: 75, height: 100)
            playerJeans.position = CGPoint(x: 0, y: 0)
            
        }
        
        
        func touchDown(atPoint pos : CGPoint) {
            
        }
        
        func touchMoved(toPoint pos : CGPoint) {
            
        }
        
        func touchUp(atPoint pos : CGPoint) {
            
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        }
        
        
        override func update(_ currentTime: TimeInterval) {
            // Called before each frame is rendered
        }

    
}
