//
//  RegisterViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/08/12.
//

import UIKit

class RegisterViewController : UIViewController {
    
    @IBOutlet weak var checkButton : UIButton!
    @IBOutlet weak var pictureView : UIView!
    
    let underlineAttributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    override func viewDidLoad() {
        pictureView.layer.cornerRadius = 6.0
        
        let checkButtonAttrubutesString = NSAttributedString(
            string: "중복확인", attributes: underlineAttributes)
        
        checkButton.setAttributedTitle(checkButtonAttrubutesString, for: .normal)
        
        let readerGesture = UITapGestureRecognizer(target: self, action: #selector(self.showReaderPage(sender:)))
        
        self.pictureView.addGestureRecognizer(readerGesture)
        
    }
    
    @IBAction func dismissView(){
        dismiss(animated: true)
    }
    
    @objc func showReaderPage(sender:UIGestureRecognizer){
            
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Reader_yw")
            
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
        self.present(vc, animated: true)
        }
    
}
