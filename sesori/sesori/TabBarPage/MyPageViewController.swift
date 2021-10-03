//
//  MyPageViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/10/03.
//

import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var mainView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 50
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        // Do any additional setup after loading the view.
    }
    

}
