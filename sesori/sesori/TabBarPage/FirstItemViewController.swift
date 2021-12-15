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
    @IBOutlet weak var calendarView : UIView!
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var todayDateLabel : UILabel!
    
    override func viewDidLoad() {
        studentView?.layer.cornerRadius = 40
        studentView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        let lunchGesture = UITapGestureRecognizer(target: self, action: #selector(self.showLunchPage(sender:)))
        let timetableGesture = UITapGestureRecognizer(target: self, action: #selector(self.showTimetablePage(sender:)))
        let calendarGesture = UITapGestureRecognizer(target: self, action: #selector(self.showCalendarPage(sender:)))
        
        self.lunchView.addGestureRecognizer(lunchGesture)
        self.timetableView.addGestureRecognizer(timetableGesture)
        self.calendarView.addGestureRecognizer(calendarGesture)
        
        mainView.layer.cornerRadius = 50
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        todayDateLabel.text = formatter.string(from: todayDate)
        
        studentLabel.text = "\(UserDefaults.standard.string(forKey: "name")!) 학생"
        
    }
    
    @objc func showLunchPage(sender:UIGestureRecognizer){
            
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Lunch_yw")
            
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
        self.present(vc, animated: true)
        }
    
    @objc func showTimetablePage(sender:UIGestureRecognizer){
            
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Timetable_yw")
            
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
        self.present(vc, animated: true)
        }
    
    @objc func showCalendarPage(sender:UIGestureRecognizer){
            
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Calendar_yw")
            
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
        self.present(vc, animated: true)
        }
    
}
