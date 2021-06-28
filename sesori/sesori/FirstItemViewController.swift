//
//  FirstItemViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/19.
//

import UIKit

class FirstItemViewController : UIViewController {
    @IBOutlet weak var studentView : UIView!
    @IBOutlet weak var lunchUIView : UIView!
    
    override func viewDidLoad() {
        studentView?.layer.cornerRadius = 40
        studentView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
