//
//  FirstItemViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/19.
//

import UIKit

class FirstItemViewController : UIViewController {
    @IBOutlet weak var studentView : UIView!
    @IBOutlet weak var lunchUIView : UIControl!
    
    override func viewDidLoad() {
        studentView?.layer.cornerRadius = 40
        studentView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goPage(sender:)))
        self.lunchUIView.addGestureRecognizer(gesture)

    }
    
    @objc func goPage(sender:UIGestureRecognizer){
            
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Lunch_yw")
            
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
        self.present(vc, animated: true)
        }
    
}
