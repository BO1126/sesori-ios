//
//  LunchViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/19.
//

import UIKit
import Alamofire

class LunchViewController : UIViewController {
    
    @IBOutlet weak var TodayLunchLabel : UILabel!
    
    override func viewDidLoad() {
        getLunchData()
    }
    
    func getLunchData(){
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyyMMdd"
//        let todaydate : String = dateformatter.string(from: Date())
        let url = "https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&pIndex=1&pSize=1&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010537&MLSV_YMD=20210518&KEY=406a6783d8db4d5483fd44abf25d720f"
        
        AF.request(url,
                   method: .get).response{
                    response in
                    let lunch = String(data: response.data!, encoding: .utf8)
                    self.convertLunchText(todaylunch: lunch!)
                   }
    }
    
    func convertLunchText(todaylunch : String){
        let converter : String = todaylunch
        self.TodayLunchLabel.text = converter.replacingOccurrences(of: "<br/>", with: "\n")
    }
    
    
}
