//
//  Sprite.swift
//  xCode9DatabaseExample
//
//  Created by Amaya Rojas Nicolas F. on 3/29/19.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import SpriteKit


var player = SKSpriteNode?()
var playerColor = UIColor.orangeColor()
var backgroundColorCustom = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
var playerSize = CGSize(width: 50, height: 50)

class GameScene{
    override func didMoveToView(view: SKView){
        
        self.backgroundColor = backgroundColorCustom
        
    }
    override func touchesBegan(touches: Set<UITouch>,withEvent event: UIEvent?){
        
        for touch in touches{
            
            
            
        }
        
    }
    
    func spawnPlayer(){
        
        player = SKSpriteNode(color: playerColor, size: playerSize)
        player?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 200)
        
        self.addChild(player!)
        
    }
}
