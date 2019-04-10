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
    
    //Sprite for Jeans loaded as a SKTexture
    let jeansSprite = SKTexture(imageNamed: "JeanSprite1.png")
    //Sprite for Platform loaded as a SKTexture
    let platformSprite = SKTexture(imageNamed: "platform.png")
    let playerJeans = SKSpriteNode(imageNamed: "JeanSprite1.png") //Not loading with SKTexture(jeansSprite) to avoid "self not available" error
    
    //Sprite for buttons saved as a string
    let buttonImage = "arrowimage.png"
    
    //Left Arrow button object
    let leftArrowButton = UIButton(frame: CGRect(x: -15, y: 275, width: 150, height: 150))
    //Right Arrow button object
    let rightArrowButton = UIButton(frame: CGRect(x: 100, y: 275, width: 150, height: 150))
    //Up Arrow button object
    let upArrowButton = UIButton(frame: CGRect(x: 600, y: 275, width: 150, height: 150))
    
    
        override func didMove(to view: SKView) {
            for view in (self.view?.subviews)! {
                view.removeFromSuperview()
            }
            
            //Player code-- Adding to SceneGraph and initializing
            addChild(playerJeans)
            playerJeans.size = CGSize(width: 75, height: 100)
            playerJeans.position = CGPoint(x: 0, y: 50)
            let constraints: NSArray = [SKConstraint.zRotation(SKRange(lowerLimit: 0, upperLimit: 0))]
            playerJeans.constraints = (constraints as! [SKConstraint])
            playerJeans.physicsBody = SKPhysicsBody(texture: jeansSprite, size: playerJeans.size)
            
            //Platform code-- Adding to SceneGraph and initializing
            let platform1 = SKSpriteNode(texture: platformSprite)
            platform1.size = CGSize(width: 250, height: 75)
            platform1.position = CGPoint(x: 0, y: -150)
            platform1.physicsBody = SKPhysicsBody(texture: platformSprite, size: platform1.size)
            platform1.physicsBody?.isDynamic = false
            addChild(platform1)
            
            //Left Arrow code-- initialization
            leftArrowButton.setTitle("Left Arrow", for: .normal)
            if let leftArrowButtonImg = UIImage(named: buttonImage) {
                leftArrowButton.setImage(leftArrowButtonImg, for: .normal)
            }
            leftArrowButton.addTarget(self, action: #selector(LevelOne.buttonStay(_:)), for: .touchDown)
            self.view?.addSubview(leftArrowButton)
            
            //Right Arrow code-- initialization
            rightArrowButton.setTitle("Right Arrow", for: .normal)
            if let rightArrowButtonImg = UIImage(named: buttonImage) {
                rightArrowButton.setImage(rightArrowButtonImg, for: .normal)
            }
            rightArrowButton.addTarget(self, action: #selector(LevelOne.buttonStay(_:)), for: .touchDown)
            self.view?.addSubview(rightArrowButton)
            
            //Up Arrow code-- initialization
            upArrowButton.setTitle("Up Arrow", for: .normal)
            if let upArrowButtonImg = UIImage(named: buttonImage) {
                upArrowButton.setImage(upArrowButtonImg, for: .normal)
            }
            upArrowButton.addTarget(self, action: #selector(LevelOne.buttonAction(_:)), for: .touchDown)
            self.view?.addSubview(upArrowButton)
            
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

    //Button Press
    @objc func buttonAction(_ sender: UIButton!) {
        if(sender == upArrowButton) {
            print("up")
            playerJeans.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
        }
    }
    
    //Button Stay
    @objc func buttonStay(_ sender: UIButton!) {
        if(sender == leftArrowButton){
            print("left")
        }
            
        else if(sender == rightArrowButton) {
            print("right")
        }
    }
    
    
}
