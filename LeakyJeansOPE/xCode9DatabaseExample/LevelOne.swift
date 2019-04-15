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

enum CollisionTag: UInt32 {
    
    case player = 0b01
    case platform = 0b10
    
}

class LevelOne: SKScene, SKPhysicsContactDelegate {
    
    let myCamera = SKCameraNode()
    
    //Background for the Scene
    let background = SKSpriteNode(imageNamed: "background.png")
    
    //Object that the player will be controlling
    var playerJeans: Jeans = Jeans()
    
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
            
            //Set the contact delegate to this scene
            physicsWorld.contactDelegate = self
            
            //Add our Camera to the Scene
            addChild(myCamera)
            camera = myCamera
            
            //Adding Background to the Scene
            addChild(background)
            background.size = CGSize(width: size.width, height: (size.height / 2) - 250)
            background.zPosition = -1
            
            //Player code-- Adding to SceneGraph and initializing
            playerJeans.InitializeAttributes()
            addChild(playerJeans.jeansSpriteNode)
            
            //Platform code-- Adding to SceneGraph and initializing
            //====================================================================
            let platform1 = Platform()
            platform1.InitializeAttributes(position: CGPoint(x: 0, y: -150))
            addChild(platform1.platformSpriteNode)
            
            let platform2 = Platform()
            platform2.InitializeAttributes(position: CGPoint(x: 250, y: -50))
            addChild(platform2.platformSpriteNode)
            
            let platform3 = Platform()
            platform3.InitializeAttributes(position: CGPoint(x: 500, y: 0))
            addChild(platform3.platformSpriteNode)
            //====================================================================
            
            //Left Arrow code-- initialization
            leftArrowButton.setTitle("Left Arrow", for: .normal)
            if let leftArrowButtonImg = UIImage(named: "arrowimageleft.png") {
                leftArrowButton.setImage(leftArrowButtonImg, for: .normal)
            }
            leftArrowButton.addTarget(self, action: #selector(LevelOne.buttonAction(_:)), for: .touchDown)
            leftArrowButton.addTarget(self, action: #selector(LevelOne.buttonExit(_:)), for: .touchUpInside)
            self.view?.addSubview(leftArrowButton)
            
            //Right Arrow code-- initialization
            rightArrowButton.setTitle("Right Arrow", for: .normal)
            if let rightArrowButtonImg = UIImage(named: "arrowimage.png") {
                rightArrowButton.setImage(rightArrowButtonImg, for: .normal)
            }
            rightArrowButton.addTarget(self, action: #selector(LevelOne.buttonAction(_:)), for: .touchDown)
            rightArrowButton.addTarget(self, action: #selector(LevelOne.buttonExit(_:)), for: .touchUpInside)
            self.view?.addSubview(rightArrowButton)
            
            //Up Arrow code-- initialization
            upArrowButton.setTitle("Up Arrow", for: .normal)
            if let upArrowButtonImg = UIImage(named: "arrowimageup.png") {
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
            background.position.x = playerJeans.jeansSpriteNode.position.x
            background.position.y = playerJeans.jeansSpriteNode.position.y
        }

        func didBegin(_ contact: SKPhysicsContact) {
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Platform") {
                playerJeans.isGrounded = true
            }
        }
    
    //Button Press
    @objc func buttonAction(_ sender: UIButton!) {
        if(sender == upArrowButton) {
            playerJeans.Jump()
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
