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
    
    //Play button object
    let playButton = UIButton(frame: CGRect(x: 225, y: 145, width: 225, height: 60))
    //Options button object
    let optionsButton = UIButton(frame: CGRect(x: 260, y: 220, width: 160, height: 60))
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .orange

        //Create the background object and give it to the SceneGraph-- Change size to be drawn in display
        let background = SKSpriteNode(imageNamed: "MainMenu.png")
        addChild(background)
        background.size = CGSize(width: size.width, height: (size.height / 2) - 250)
        background.zPosition = -1
        
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
