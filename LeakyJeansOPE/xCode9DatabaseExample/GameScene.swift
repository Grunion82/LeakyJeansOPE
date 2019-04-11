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
    
    //Play button object
    let playButton = UIButton(frame: CGRect(x: 225, y: 145, width: 225, height: 60))
    //Options button object
    let optionsButton = UIButton(frame: CGRect(x: 260, y: 220, width: 160, height: 60))
    
    
    private var playerSprite = SKSpriteNode()
    private var playerWalkingFrames: [SKTexture] = []
    

    override func didMove(to view: SKView) {
        backgroundColor = .orange
       //updated background of the game
        let background = SKSpriteNode(imageNamed: "background.png")
        background.position = CGPoint(x: 1, y: 1)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)//anchor center of teh screen default
        background.zPosition = -1
        background.size = CGSize(width: size.width, height: size.height/2)
        addChild(background)
        

        //Create the background object and give it to the SceneGraph-- Change size to be drawn in display
        let background = SKSpriteNode(imageNamed: "MainMenu.png")
        addChild(background)
        background.size = CGSize(width: size.width, height: (size.height / 2) - 250)

        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }

        
       

        
        //Code for PlayButton. Loading and Positioning
        playButton.setTitle("PlayButton", for: .normal)
        if let playButtonImg = UIImage(named: "PlayButton.png") {
            playButton.setImage(playButtonImg, for: .normal)
        }
        playButton.addTarget(self, action: #selector(GameScene.buttonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(playButton)
        
        //Code for OptionsButton. Loading and Positioning
        optionsButton.setTitle("OptionsButton", for: .normal)
        if let optionsButtonImg = UIImage(named: "OptionsButton.png") {
            optionsButton.setImage(optionsButtonImg, for: .normal)
        }
        optionsButton.addTarget(self, action: #selector(GameScene.buttonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(optionsButton)
        
        //buildPlayer()
        //animatePLayer()
    }
    

    
    
    func buildPlayer() {
        var walkFrames: [SKTexture] = [SKTexture(imageNamed: "tile000"),SKTexture(imageNamed: "tile001"),SKTexture(imageNamed: "tile002"),SKTexture(imageNamed: "tile003"),SKTexture(imageNamed: "tile004"),SKTexture(imageNamed: "tile005"),SKTexture(imageNamed: "tile006"),SKTexture(imageNamed: "tile007"),SKTexture(imageNamed: "tile008"),SKTexture(imageNamed: "tile009"),SKTexture(imageNamed: "tile010"),SKTexture(imageNamed: "tile011"),SKTexture(imageNamed: "tile012"),SKTexture(imageNamed: "tile013"),SKTexture(imageNamed: "tile014"),SKTexture(imageNamed: "tile015")]
        

        let numImages = walkFrames.count
        for i in 1...numImages {
            walkFrames.append(walkFrames[i])
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
    
    @objc func buttonAction(_ sender: UIButton!) {
        if(sender == playButton){
            
            //Loads the LevelOne scene
            if let newScene = LevelOne(fileNamed: "LevelOne") {
                newScene.scaleMode = .aspectFill
                let transition = SKTransition.moveIn(with: .right, duration: 0.25)
                playButton.removeFromSuperview()
                optionsButton.removeFromSuperview()
                self.view?.presentScene(newScene, transition: transition)
            }
        }
        else if(sender == optionsButton) {
            
        }
    }
}
