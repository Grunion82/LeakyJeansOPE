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

enum Animation {
    case idle,walking,jumping, tDamage
}

class LevelOne: SKScene {
    
    //Sprite for Jeans loaded as a SKTexture
    let jeansSprite = SKTexture(imageNamed: "JeanSprite1.png")
    //Sprite for Platform loaded as a SKTexture
    let platformSprite = SKTexture(imageNamed: "platform.png")
    //keep track of current anim
    var Currentanim = Animation.idle
    
    var moveLeft = false
    var moveRight = false
    
    //Sprite for buttons saved as a string
    let buttonImage = "arrowimage.png"
    
    //Left Arrow button object
    let leftArrowButton = UIButton(frame: CGRect(x: -15, y: 275, width: 150, height: 150))
    //Right Arrow button object
    let rightArrowButton = UIButton(frame: CGRect(x: 100, y: 275, width: 150, height: 150))
    //Up Arrow button object
    let upArrowButton = UIButton(frame: CGRect(x: 600, y: 275, width: 150, height: 150))
    //player sprite
    private var playerJeans = SKSpriteNode()
    //player frames
    private var playerWalkingFrames: [SKTexture] = []
    private var playerJumpingFrames: [SKTexture] = []
    private var playeridleFrames: [SKTexture] = []
    private var playerTakingDmgFrames: [SKTexture] = []
    
            var walkFrames: [SKTexture] = [SKTexture(imageNamed: "walk000"),SKTexture(imageNamed: "walk001"),SKTexture(imageNamed: "walk002"),SKTexture(imageNamed: "walk003"),SKTexture(imageNamed: "walk004"),SKTexture(imageNamed: "walk005"),SKTexture(imageNamed: "walk006"),SKTexture(imageNamed: "walk007")]
    
    
        override func didMove(to view: SKView) {
            for view in (self.view?.subviews)! {
                view.removeFromSuperview()
            }
            buildPlayer(walkFrames)
            //Player code-- Adding to SceneGraph and initializing
            //addChild(playerJeans)
            playerJeans.size = CGSize(width: 100, height: 100)
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
            
            
            switch Currentanim {
            case .idle:
                playerJeans.run(SKAction.repeatForever(
                    SKAction.animate(with: playeridleFrames, timePerFrame: 0.1, resize: false,restore: true)),withKey:"idle")
                break;
            case .walking:
                playerJeans.run(SKAction.repeatForever(
                    SKAction.animate(with: playerWalkingFrames, timePerFrame: 0.1, resize: false,restore: true)),withKey:"walking")
                break;
            case.jumping:
                playerJeans.run(SKAction.repeatForever(
                    SKAction.animate(with: playerJumpingFrames, timePerFrame: 0.1, resize: false,restore: true)),withKey:"jumping")
                break;
            case .tDamage:
                playerJeans.run(SKAction.repeatForever(
                    SKAction.animate(with: playerTakingDmgFrames, timePerFrame: 0.1, resize: false,restore: true)),withKey:"takingDmg")
                break;
            default:
                Currentanim = .idle
                break;
            }
            
            //animatePLayer()
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
            if(moveLeft == true) {
                playerJeans.position.x += -1.0
            }
            if(moveRight == true) {
                playerJeans.position.x += 1.0
            }
        }

    //Button Press
    @objc func buttonAction(_ sender: UIButton!) {
        if(sender == upArrowButton) {
            playerJeans.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
        }
        if(sender == leftArrowButton){
            moveLeft = true
        }
            
        if(sender == rightArrowButton) {
            moveRight = true
        }
    }
    
    //Button Stay
    @objc func buttonExit(_ sender: UIButton!) {
        if(sender == leftArrowButton){
            moveLeft = false
        }
        
        if(sender == rightArrowButton) {
            moveRight = false
        }

    }
    
    func buildPlayer(_ frames: [SKTexture]) {

        var dummy:[SKTexture]  = frames
        
        let numImages = dummy.count
        for i in 1...numImages {
            dummy.append(dummy[i])
        }
        playerWalkingFrames = dummy
        
        let firstFrameTexture = dummy[0]
        playerJeans = SKSpriteNode(texture: firstFrameTexture)
        playerJeans.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playerJeans)
        
    }
    
    

    func animatePLayer() {
        playerJeans.run(SKAction.repeatForever(
            SKAction.animate(with: playerWalkingFrames, timePerFrame: 0.1, resize: false,restore: true)),withKey:"walking")
    }
    
    
}
