//
//  StudentNumberAlterViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/11/18.
//

import UIKit

class StudentNumberAlterViewController: UIViewController {
    
    @IBOutlet weak var popupView : UIVisualEffectView!
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
        let pattern = "^[1-3]{1,1}0[1-9]{1,1}[0-9]{2,2}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: studentNumberTextField.text!, options: [], range: NSRange(location: 0, length: studentNumberTextField.text!.count)) {
            UserDefaults.standard.set(studentNumberTextField.text, forKey: "studentNumber")
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
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
