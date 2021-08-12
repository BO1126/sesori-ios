//
//  CustomLoginButton.swift
//  sesori
//
//  Created by 이정우 on 2021/08/12.
//

import UIKit

class CustomRoundButton : UIButton{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0
        
    }
    
}
