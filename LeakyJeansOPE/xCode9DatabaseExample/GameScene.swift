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
    
    
    override func didMove(to view: SKView) {
        
        //Create the background object and give it to the SceneGraph-- Change size to be drawn in display
        let background = SKSpriteNode(imageNamed: "MainMenu.png")
        addChild(background)
        background.size = CGSize(width: size.width, height: (size.height / 2) - 250)
        
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
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        if(sender == playButton){
            print("play button")
            
            //Loads the LevelOne scene
            if let newScene = LevelOne(fileNamed: "LevelOne") {
                newScene.scaleMode = .aspectFill
                let transition = SKTransition.moveIn(with: .right, duration: 0.25)
                self.view?.presentScene(newScene, transition: transition)
                playButton.isHidden = true
                optionsButton.isHidden = true
            }
        }
        else if(sender == optionsButton) {
            print("options button")
        }
    }
}
