//
//  StudentNumberAlterViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/11/18.
//

import UIKit

class StudentNumberAlterViewController: UIViewController {
    
    @IBOutlet weak var popupView : UIView!
    @IBOutlet weak var studentNumberTextField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.clipsToBounds = true
        popupView.layer.masksToBounds = true
        popupView.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissView(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchSubmitButton(){
        let pattern = "^[0-9]{5,5}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: studentNumberTextField.text!, options: [], range: NSRange(location: 0, length: studentNumberTextField.text!.count)) {
            UserDefaults.standard.set(studentNumberTextField.text, forKey: "studentNumber")
            dismiss(animated: true, completion: nil)
        }else{
            shakeTextField(textField: studentNumberTextField)
        }
    }
    
    func shakeTextField(textField: UITextField) -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 10
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 20
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 10
                })
            })
        })
    }
}
