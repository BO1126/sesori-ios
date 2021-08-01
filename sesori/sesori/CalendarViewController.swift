//
//  CalendarViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/07/30.
//

import UIKit
import Alamofire

class CalendarViewController : UIViewController {
    
    @IBOutlet weak var datepicker : UIDatePicker!
    @IBOutlet weak var calendarLabel : UILabel!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func dismissView(){
        dismiss(animated: true)
    }
    
    
    
}
