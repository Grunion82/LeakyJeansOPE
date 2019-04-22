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
    
    case player = 0b1       //1
    case platform = 0b10    //2
    case spike = 0b11       //3
    case oil = 0b100        //4
    case fan = 0b101        //5
    case water = 0b110      //6
    case finish = 0b111     //7
    
}

class LevelOne: SKScene, SKPhysicsContactDelegate {
    
    //Camera that will be looking at the scene
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
    //Sprite Node to show player's water level
    let waterLevelNode = SKSpriteNode(color: .blue, size: CGSize(width: 125, height: 25))
    //Holds the initial width of the waterLevelNode
    var waterLevelWidth: CGFloat = 0.0
    //Sprite Node to show player's oil level
    let oilLevelNode = SKSpriteNode(color: .black, size: CGSize(width: 125, height: 25))
    //Frame for the waterLevelNode
    var frameNode = SKShapeNode()
    
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
            background.zPosition = -1   //Moves the background behind all other objects
            
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
            
            let platform4 = Platform()
            platform4.InitializeAttributes(position: CGPoint(x: 825, y: 0))
            addChild(platform4.platformSpriteNode)
            //====================================================================
            
            //Spike code-- Add to SceneGraph and initializing
            //====================================================================
            let spike1 = Spike()
            spike1.InitializeAttributes(position: CGPoint(x: 250, y: -25))
            addChild(spike1.spikeSpriteNode)
            //====================================================================
            
            //WaterToken code-- Add to SceneGraph and initializing
            //====================================================================
            let water1 = WaterToken()
            water1.InitializeAttributes(position: CGPoint(x: 825, y: 40))
            addChild(water1.waterTokenSpriteNode)
            //====================================================================
            
            //Oil spill code-- Add to SceneGraph and initializing
            //====================================================================
            let oil1 = Oil()
            oil1.InitializeAttributes(position: CGPoint(x: 500, y: 20))
            addChild(oil1.oilSpriteNode)
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
            
            //Water Level Node code-- initialization
            waterLevelNode.anchorPoint = CGPoint(x: 0.5, y: 0)
            addChild(waterLevelNode)
            waterLevelWidth = waterLevelNode.frame.size.width
            
            //Oil Level Node code-- initialization
            addChild(oilLevelNode)
            oilLevelNode.zPosition = -0.1
            
            //Frame Node-- initializaiton
            frameNode = SKShapeNode(rect: waterLevelNode.frame)
            frameNode.fillColor = .clear
            frameNode.strokeColor = .black
            addChild(frameNode)
            
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
            
            //Update the water level bar value
             UpdateLevelNodes()
            
            //Make a number of scene objects follow the player's position
            camera?.position.x = playerJeans.jeansSpriteNode.position.x
            camera?.position.y = playerJeans.jeansSpriteNode.position.y
            background.position.x = playerJeans.jeansSpriteNode.position.x
            background.position.y = playerJeans.jeansSpriteNode.position.y
            waterLevelNode.position.x = playerJeans.jeansSpriteNode.position.x
            waterLevelNode.position.y = playerJeans.jeansSpriteNode.position.y + 65
            oilLevelNode.position.x = playerJeans.jeansSpriteNode.position.x
            oilLevelNode.position.y = playerJeans.jeansSpriteNode.position.y + 77.5
            frameNode.position.x = playerJeans.jeansSpriteNode.position.x
            frameNode.position.y = playerJeans.jeansSpriteNode.position.y + 65
        }

        func didBegin(_ contact: SKPhysicsContact) {
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Platform") {
                playerJeans.isGrounded = true
            }
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Spike") {
                playerJeans.leakLevel += 0.05
            }
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Oil") {
                playerJeans.oilLevel += 3.0
            }
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Water") {
                playerJeans.wetness += 25.0
                contact.bodyB.node?.removeFromParent()
            }
        }
    
    func UpdateLevelNodes() {
        
        let ratio: CGFloat = playerJeans.wetness / playerJeans.MAX_WATER_LEVEL
        let newWidth: CGFloat = waterLevelWidth * ratio
        waterLevelNode.run(.resize(toWidth: newWidth, duration: 0.1))
        
        oilLevelNode.run(.resize(toWidth: newWidth + playerJeans.oilLevel, duration: 0.1))
        
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
