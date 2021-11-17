//
//  MyPageViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/10/03.
//

import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var subView : UIView!
    @IBOutlet weak var studentNumberLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 50
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        // Do any additional setup after loading the view.
        
        subView.layer.borderWidth = 2
        subView.layer.borderColor = CGColor(red: 104/255, green: 180/255, blue: 1, alpha: 1)
        subView.layer.cornerRadius = 20
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
        
        if let studentNumber = UserDefaults.standard.string(forKey: "studentNumber"){
            studentNumberLabel.text = studentNumber
        }else{
            studentNumberLabel.text = "00000"
        }
    }
    

}
