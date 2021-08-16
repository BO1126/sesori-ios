//
//  LunchViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/19.
//

import UIKit
import Alamofire
import SwiftyJSON

class LunchViewController : UIViewController {
    @IBOutlet weak var todayDateLabel : UILabel!
    @IBOutlet weak var todayLunchLabel : UILabel!
    @IBOutlet weak var lunchDatePicker : UIDatePicker!
    @IBOutlet weak var lunchView : UIView!
    
    
    override func viewDidLoad() {
        getLunchData()
        getDatepickerDate()
        
        lunchView.layer.cornerRadius = 20
        lunchView.layer.masksToBounds = false
        lunchView.layer.shadowOpacity = 0.2
        lunchView.layer.shadowRadius = 8
    }
    
    @IBAction func didLunchDatePickerValueChanged(){
        getLunchData()
        getDatepickerDate()
    }
    
    func getLunchData(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let pickDate = formatter.string(from: lunchDatePicker.date)
        
        let url = "https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&pIndex=1&pSize=1&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010537&MLSV_YMD="+pickDate+"&KEY=406a6783d8db4d5483fd44abf25d720f"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default,headers: [:]).responseJSON{
            response in
            switch response.result {
            case .success(let value):
                let json : JSON = JSON(value)
                if json["mealServiceDietInfo"].exists(){
                    let meal = json["mealServiceDietInfo"].arrayValue[1]
                    let row = meal["row"].arrayValue[0]
                    let ddishNm = row["DDISH_NM"].stringValue
                    let lunchString = ddishNm.replacingOccurrences(of: "<br/>", with: "\n")
                    let removeNumberString : String = lunchString.components(separatedBy: CharacterSet.decimalDigits).joined()
                    let removeDotString : String = removeNumberString.replacingOccurrences(of: ".", with: "")
                    self.todayLunchLabel.text = removeDotString
                }else{
                    self.todayLunchLabel.text = "해당 날짜는 급식이 없습니다"
                }
            default:
                return
            }
        }
    }
    
    func getDatepickerDate(){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        formatter.dateFormat = "M월 d일 E요일"
        let pickDate = formatter.string(from: lunchDatePicker.date)
        todayDateLabel.text = pickDate
    }
    
    @IBAction func dismissView(){
        dismiss(animated: true)
    }
    
    @IBAction func touchNextLunchButton(){
        lunchDatePicker.date = Calendar.current.date(byAdding: .day, value: 1,to: lunchDatePicker.date) ?? lunchDatePicker.date
        getLunchData()
        getDatepickerDate()
    }
    
    @IBAction func touchBackLunchButton(){
        lunchDatePicker.date = Calendar.current.date(byAdding: .day, value: -1, to: lunchDatePicker.date) ??
            lunchDatePicker.date
        getLunchData()
        getDatepickerDate()
    }
}
