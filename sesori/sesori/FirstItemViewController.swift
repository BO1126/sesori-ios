//
//  FirstItemViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/19.
//

import UIKit

class FirstItemViewController : UIViewController {
    @IBOutlet weak var studentView : UIView!
    @IBOutlet weak var lunchView : UIView!
    @IBOutlet weak var timetableView : UIView!
    @IBOutlet weak var studentLabel : UILabel!
    
    let userData : Array<Any> = ["이정우",6,20]
    
    override func viewDidLoad() {
        studentView?.layer.cornerRadius = 40
        studentView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        let lunchGesture = UITapGestureRecognizer(target: self, action: #selector(self.goLunchPage(sender:)))
        let timetableGesture = UITapGestureRecognizer(target: self, action: #selector(self.goTimetablePage(sender:)))
        
        self.lunchView.addGestureRecognizer(lunchGesture)
        self.timetableView.addGestureRecognizer(timetableGesture)
        
//        studentLabel.text = "\(userData[0]) 학생,"

    }
    
    @objc func goLunchPage(sender:UIGestureRecognizer){
            
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Lunch_yw")
            
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
        self.present(vc, animated: true)
        }
    
    @objc func goTimetablePage(sender:UIGestureRecognizer){
            
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Timetable_yw")
            
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
        self.present(vc, animated: true)
        }
    
}
