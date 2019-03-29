//
//  GameScene.swift
//  xCode9DatabaseExample
//
//  Created by Kevin Kruusi on 2019-02-28.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var button: UIButton?
    
    
    private var playerSprite = SKSpriteNode()
    private var playerWalkingFrames: [SKTexture] = []
    

    override func didMove(to view: SKView) {
        backgroundColor = .orange
       
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        //Create the background object and give it to the SceneGraph-- Change size to be drawn in display
        let background = SKSpriteNode(imageNamed: "MainMenu.png")
        addChild(background)
        background.size = CGSize(width: size.width, height: (size.height / 2) - 250)
        //background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
       
        
        
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
        
        
        buildPlayer()
       // animatePLayer()
    }
    
    func buildPlayer() {
        let playerAnimatedAtlas = SKTextureAtlas(named: "BearImages")
        var walkFrames: [SKTexture] = []
        
        let numImages = playerAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let playerTextureName = "bear\(i)"
            walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        playerWalkingFrames = walkFrames
        
        let firstFrameTexture = playerWalkingFrames[0]
        playerSprite = SKSpriteNode(texture: firstFrameTexture)
        playerSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playerSprite)

    }
    
    func animatePLayer() {
        playerSprite.run(SKAction.repeatForever(
            SKAction.animate(with: playerWalkingFrames, timePerFrame: 0.1, resize: false,restore: true)),withKey:"walkingInPlaceBear")
    }
    
    
    func playerMoveEnd(){
        
        playerSprite.removeAllActions()//this stops animation N
        
    }
    
    func movePlayer(location: CGPoint){//temporal move player it can move anywhere on teh screen N
        
            // 1
            var multiplierForDirection: CGFloat
            
            // 2
            let bearSpeed = frame.size.width / 3.0
            
            // 3
            let moveDifference = CGPoint(x: location.x - playerSprite.position.x, y: location.y - playerSprite.position.y)
            let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
            
            // 4
            let moveDuration = distanceToMove / bearSpeed
            
            // 5
            if moveDifference.x < 0 {
                multiplierForDirection = 1.0
            } else {
                multiplierForDirection = -1.0
            }
            playerSprite.xScale = abs(playerSprite.xScale) * multiplierForDirection
        
        

        // 1
        if playerSprite.action(forKey: "walkingInPlaceBear") == nil {
            // if legs are not moving, start them
            animatePLayer()
        }
        
        // 2
        let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
        
        // 3
        let doneAction = SKAction.run({ [weak self] in
            self?.playerMoveEnd()
        })
        
        // 4
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        playerSprite.run(moveActionWithDone, withKey:"bearMoving")

        
    }


    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
            let touch = touches.first!
            let location = touch.location(in: self)
        
        movePlayer(location: location)

        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    

}
