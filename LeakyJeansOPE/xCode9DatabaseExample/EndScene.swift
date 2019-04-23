//
//  EndScene.swift
//  xCode9DatabaseExample
//
//  Created by Bandl Noah W. on 4/22/19.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import SpriteKit

class EndScene: SKScene {
    
    //Endcase flag from LevelOne
    var endCase: UInt32 = 0
    //Score of the Jeans from LevelOne
    var score: CGFloat = 0.0
    
    //Background for the Scene
    let background = SKSpriteNode(imageNamed: "background.png")
    
    //"Title" of the scene. Either You Win! or Game Over!
    let endTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 175))
    
    //Shows the player's score after completing the level
    let scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 275, height: 90))
    
    //Menu button object
    let menuButton = UIButton(frame: CGRect(x: 250, y: 250, width: 250, height: 80))
    
    override func didMove(to view: SKView) {
        backgroundColor = .orange
        
        //End Title code-- Adding to view and initializing
        endTitle.center = CGPoint(x: 375, y: 100)
        endTitle.textAlignment = .center
        self.view?.addSubview(endTitle)
        
        //Depending on the flag, change title text
        if(endCase == 0b1) {
            endTitle.text = "You Win!"
        }
        else if(endCase == 0b10) {
            endTitle.text = "Game Over!"
        }
        
        //Score Label code-- Adding to view and initializing
        scoreLabel.text = " Your Score: " + String(describing: score)
        scoreLabel.center = CGPoint(x: 375, y: 200)
        scoreLabel.textAlignment = .center
        self.view?.addSubview(scoreLabel)
        
        //Adding Background to the Scene
        addChild(background)
        background.size = CGSize(width: size.width, height: (size.height / 2) - 250)
        background.zPosition = -1   //Moves the background behind all other objects
        
        //Code for PlayButton. Loading and Positioning
        menuButton.setTitle("MenuButton", for: .normal)
        if let playButtonImg = UIImage(named: "PlayButton.png") {
            menuButton.setImage(playButtonImg, for: .normal)
        }
        menuButton.addTarget(self, action: #selector(GameScene.buttonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(menuButton)
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
        if(sender == menuButton){
            //Loads the main menu scene
            if let newScene = GameScene(fileNamed: "GameScene") {
                newScene.scaleMode = .aspectFill
                let transition = SKTransition.moveIn(with: .right, duration: 0.25)
                endTitle.removeFromSuperview()
                scoreLabel.removeFromSuperview()
                menuButton.removeFromSuperview()
                self.view?.presentScene(newScene, transition: transition)
            }
        }
    }
}
