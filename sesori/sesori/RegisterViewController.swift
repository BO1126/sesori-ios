//
//  RegisterViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/08/12.
//

import UIKit

class RegisterViewController : UIViewController {
    
    @IBOutlet weak var checkButton : UIButton!
    
    let underlineAttributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    override func viewDidLoad() {
        let checkButtonAttrubutesString = NSAttributedString(
            string: "중복확인", attributes: underlineAttributes)
        
        checkButton.setAttributedTitle(checkButtonAttrubutesString, for: .normal)
    }
    
    @IBAction func dismissView(){
        dismiss(animated: true)
    }
    
}
