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
    
    let myCamera = SKCameraNode()
    
    //Object that the player will be controlling
    var playerJeans: Jeans = Jeans()
    
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
            addChild(myCamera)
            camera = myCamera
            
            //Player code-- Adding to SceneGraph and initializing
            playerJeans.InitializeAttributes()
            addChild(playerJeans.jeansSpriteNode)
            
            //Platform code-- Adding to SceneGraph and initializing
            let platform1 = Platform()
            platform1.InitializeAttributes(position: CGPoint(x: 0, y: -150))
            addChild(platform1.platformSpriteNode)
            
            //Left Arrow code-- initialization
            leftArrowButton.setTitle("Left Arrow", for: .normal)
            if let leftArrowButtonImg = UIImage(named: buttonImage) {
                leftArrowButton.setImage(leftArrowButtonImg, for: .normal)
            }
            leftArrowButton.addTarget(self, action: #selector(LevelOne.buttonAction(_:)), for: .touchDown)
            leftArrowButton.addTarget(self, action: #selector(LevelOne.buttonExit(_:)), for: .touchUpInside)
            self.view?.addSubview(leftArrowButton)
            
            //Right Arrow code-- initialization
            rightArrowButton.setTitle("Right Arrow", for: .normal)
            if let rightArrowButtonImg = UIImage(named: buttonImage) {
                rightArrowButton.setImage(rightArrowButtonImg, for: .normal)
            }
            rightArrowButton.addTarget(self, action: #selector(LevelOne.buttonAction(_:)), for: .touchDown)
            rightArrowButton.addTarget(self, action: #selector(LevelOne.buttonExit(_:)), for: .touchUpInside)
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
            playerJeans.UpdatePosition()
            camera?.position.x = playerJeans.jeansSpriteNode.position.x
            camera?.position.y = playerJeans.jeansSpriteNode.position.y
        }

    //Button Press
    @objc func buttonAction(_ sender: UIButton!) {
        if(sender == upArrowButton) {
            playerJeans.jeansSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
        }
        if(sender == leftArrowButton){
            playerJeans.moveLeft = true
        }
            
        if(sender == rightArrowButton) {
            playerJeans.moveRight = true
        }
    }
    
    //Button Exit
    @objc func buttonExit(_ sender: UIButton!) {
        if(sender == leftArrowButton){
            playerJeans.moveLeft = false
        }
        
        if(sender == rightArrowButton) {
            playerJeans.moveRight = false
        }

    }
    
    
}
