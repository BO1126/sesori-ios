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
        loadCalenderData()
    }
    
    @IBAction func dismissView(){
        dismiss(animated: true)
    }
    
    @IBAction func datepickerValueChanged(){
        loadCalenderData()
    }
    
    func loadCalenderData(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let pickDate = formatter.string(from: datepicker.date)
        
        let url = "https://open.neis.go.kr/hub/SchoolSchedule?Type=json&pIndex=1&pSize=1&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010537&KEY=406a6783d8db4d5483fd44abf25d720f&AA_YMD="+pickDate
        
        
        
    }
    
}
