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

enum EndGameFlag: UInt32 {
    
    case win = 0b1          //1
    case lose = 0b10        //2
}

class LevelOne: SKScene, SKPhysicsContactDelegate {
    
    //Camera that will be looking at the scene
    let myCamera = SKCameraNode()
    
    //Background for the Scene
    let background = SKSpriteNode(imageNamed: "background.png")
    
    //Object that the player will be controlling
    var playerJeans: Jeans = Jeans()
    
    //For timer
    var seconds = 120
    var sceneTimer = Timer()
    
    //Left Arrow button object
    let leftArrowButton = UIButton(frame: CGRect(x: -15, y: 275, width: 150, height: 150))
    //Right Arrow button object
    let rightArrowButton = UIButton(frame: CGRect(x: 100, y: 275, width: 150, height: 150))
    //Up Arrow button object
    let upArrowButton = UIButton(frame: CGRect(x: 600, y: 275, width: 150, height: 150))
    //Shows how much time remains
    let timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 175))
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
            
            let platform5 = Platform()
            platform5.InitializeAttributes(position: CGPoint(x: 1100, y: -100))
            addChild(platform5.platformSpriteNode)
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
            water1.InitializeAttributes(position: CGPoint(x: 800, y: 40))
            addChild(water1.waterTokenSpriteNode)
            
            let water2 = WaterToken()
            water2.InitializeAttributes(position: CGPoint(x: 850, y: 40))
            addChild(water2.waterTokenSpriteNode)
            
            let water3 = WaterToken()
            water3.InitializeAttributes(position: CGPoint(x: 1050, y: -60))
            addChild(water3.waterTokenSpriteNode)
            //====================================================================
            
            //Oil spill code-- Add to SceneGraph and initializing
            //====================================================================
            let oil1 = Oil()
            oil1.InitializeAttributes(position: CGPoint(x: 500, y: 20))
            addChild(oil1.oilSpriteNode)
            //====================================================================
            
            //Finsh Flag code-- Add to SceneGraph and initializing
            //====================================================================
            let finishFlag = Flag()
            finishFlag.InitializeAttributes(position: CGPoint(x: 1200, y: -25))
            addChild(finishFlag.flagSpriteNode)
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
            
            //Time Label code-- Adding to view and initializing
            timeLabel.center = CGPoint(x: 375, y: 50)
            timeLabel.textAlignment = .center
            self.view?.addSubview(timeLabel)
            
            //Water Level Node code-- initialization
            waterLevelNode.anchorPoint = CGPoint(x: 0.5, y: 0)
            addChild(waterLevelNode)
            waterLevelWidth = waterLevelNode.frame.size.width
            
            //Oil Level Node code-- initialization
            addChild(oilLevelNode)
            oilLevelNode.zPosition = -0.1   //Makes the sprite appear behind the water's 
            
            //Frame Node-- initializaiton
            frameNode = SKShapeNode(rect: waterLevelNode.frame)
            frameNode.fillColor = .clear
            frameNode.strokeColor = .black
            addChild(frameNode)
            
        }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        sceneTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LevelOne.updateSceneTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateSceneTimer(){
     seconds -= 1

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
            
            //Called before each frame is rendered
            playerJeans.UpdatePosition()
            
            //Update Time Label
            timeLabel.text = "Time: " + String(describing: seconds)
            if(seconds <= 0) {
                EndGame(EndGameFlag.lose)
            }
            
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
            //Player collides with platform
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Platform") {
                playerJeans.isGrounded = true
            } //Player collides with spike
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Spike") {
                playerJeans.leakLevel += 0.05
                playerJeans.animatePLayer(Animation.tDamage)
            } //Player collides with Oil
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Oil") {
                playerJeans.oilLevel += 1.0
            } //Player collides with Water
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Water") {
                playerJeans.wetness += 25.0
                contact.bodyB.node?.removeFromParent()
            } //Player collides with End Flag
            if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Flag") {
                EndGame(EndGameFlag.win)
            }
        }
    
    func UpdateLevelNodes() {
        //Update the water level's value (width)
        var ratio: CGFloat = playerJeans.wetness / playerJeans.MAX_WATER_LEVEL
        var newWidth: CGFloat = waterLevelWidth * ratio
        waterLevelNode.run(.resize(toWidth: newWidth, duration: 0.1))
        
        //Update the oil level's value (width)
        ratio = playerJeans.oilLevel / playerJeans.MAX_WATER_LEVEL
        newWidth = newWidth + waterLevelWidth * ratio
        oilLevelNode.run(.resize(toWidth: newWidth, duration: 0.1))
        
    }
    
    //Calculates the final score of the game
    func CalculateScore() -> CGFloat {
        return playerJeans.wetness * 0.6 + CGFloat(seconds) * 0.5
    }
    
    func EndGame(_ endCase: EndGameFlag) {
        let finalScore = CalculateScore()
        sceneTimer.invalidate()
        seconds = 120
        //Swap to end scene
        if let newScene = EndScene(fileNamed: "EndScene") {
            newScene.scaleMode = .aspectFill
            newScene.endCase = endCase.rawValue
            newScene.score = finalScore
            let transition = SKTransition.moveIn(with: .right, duration: 0.25)
            leftArrowButton.removeFromSuperview()
            rightArrowButton.removeFromSuperview()
            upArrowButton.removeFromSuperview()
            timeLabel.removeFromSuperview()
            self.view?.presentScene(newScene, transition: transition)
        }
    }
    
    //Button Press
    @objc func buttonAction(_ sender: UIButton!) {
        if(sender == upArrowButton) {
            playerJeans.Jump()              //Player jump
        }
        if(sender == leftArrowButton){
            playerJeans.moveLeft = true     //Player moves to the left
            playerJeans.animatePLayer(Animation.walking)
        }
            
        if(sender == rightArrowButton) {
            playerJeans.moveRight = true    //Player move to the right
            playerJeans.animatePLayer(Animation.walking)
        }
    }
    
    //Button Exit
    @objc func buttonExit(_ sender: UIButton!) {
        if(sender == leftArrowButton){
            playerJeans.moveLeft = false    //Player no longer moving left
            playerJeans.animatePLayer(Animation.idle)
        }
        
        if(sender == rightArrowButton) {
            playerJeans.moveRight = false   //Player no longer moving right
            playerJeans.animatePLayer(Animation.idle)
        }

    }
    
    
}
