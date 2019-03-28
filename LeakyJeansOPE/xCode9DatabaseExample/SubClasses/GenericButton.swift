//
//  GenericButton.swift
//  xCode9DatabaseExample
//
//  Created by Yaghob Philip on 3/28/19.
//  Copyright © 2019 com.kevin.MetalWarriorsTribute. All rights reserved.
//

import UIKit

class GenericButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton(){
        layer.borderWidth = 2.0
        layer.cornerRadius = frame.size.height/2
        
        addTarget(self, action: #selector(GenericButton.buttonPressed), for: .touchDown)
    }
    
    @objc func buttonPressed(){
        activateButton()
    }
    
    func activateButton(){
        
        
    }
}
