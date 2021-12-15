//
//  TemporaryLoginViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/11/14.
//

import UIKit

class TemporaryLoginViewController: UIViewController {
    
    @IBOutlet weak var studentNumberTextField : UITextField!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var loginFailedLabel : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = UserDefaults.standard.string(forKey: "studentNumber"){
            DispatchQueue.main.async {
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let popupVC = storyBoard.instantiateViewController(withIdentifier: "TemporaryLoginWaitVC")
                popupVC.modalPresentationStyle = .overCurrentContext
                popupVC.modalTransitionStyle = .crossDissolve
                self.present(popupVC, animated: true, completion: nil)
                
            }
        }
        
    }
    
    @IBAction func touchLoginButton(){
        if(nameTextField.text == ""){
            loginFailedLabel.text = "이름을 입력해주세요"
            return
        }
        else if(studentNumberTextField.text == ""){
            loginFailedLabel.text = "학번을 입력해주세요"
            return
        }
        let pattern = "^[가-힣]{2,5}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: nameTextField.text!, options: [], range: NSRange(location: 0, length: nameTextField.text!.count)) {
            let pattern2 = "^[1-3]{1,1}0[1-9]{1,1}[0-9]{2,2}$"
            let regex2 = try? NSRegularExpression(pattern: pattern2)
            if let _ = regex2?.firstMatch(in: studentNumberTextField.text!, options: [], range: NSRange(location: 0, length: studentNumberTextField.text!.count)) {
                Login()
            }else{
                loginFailedLabel.text = "학번을 올바르게 입력해주세요"
                return
            }
        }else{
            loginFailedLabel.text = "이름을 올바르게 입력해주세요"
            return
        }
    }
    
    func Login(){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
        view?.modalTransitionStyle = .coverVertical
        view?.modalPresentationStyle = .fullScreen
        self.present(view!, animated: true, completion: nil)
        UserDefaults.standard.set(self.nameTextField.text, forKey: "name")
        UserDefaults.standard.set(self.studentNumberTextField.text, forKey: "studentNumber")
    }
    
}
