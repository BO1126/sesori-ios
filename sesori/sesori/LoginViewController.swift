//
//  LoginViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/08/12.
//

import UIKit

class LoginViewController : UIViewController {
    
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var registerButton : UIButton!
       
    let underlineAttributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
             
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let findButtonAttributeString = NSMutableAttributedString(
            string: "아이디 / 비밀번호 찾기", attributes: underlineAttributes
        )
        
        let registerButtonAttributeString = NSMutableAttributedString(
            string: "아직 가입을 안했나요?", attributes: underlineAttributes
        )
        
        findButton.setAttributedTitle(findButtonAttributeString, for: .normal)
        registerButton.setAttributedTitle(registerButtonAttributeString, for: .normal)
    }
    
}
