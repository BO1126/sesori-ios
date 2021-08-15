//
//  LunchViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/19.
//

import UIKit
import Alamofire

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
        
        AF.request(url, method: .get).responseJSON{
                    response in
                    let decoder = JSONDecoder()
                    let lunchData = try? decoder.decode(Lunch.self, from: response.data!)
                    if let lunch = lunchData{
                        var lunchString : String = "\(String(describing: lunch))"
                        lunchString = lunchString.replacingOccurrences(of: "<br/>", with: "\n")
                        let lunchArray : Array = lunchString.components(separatedBy: "\"")
                        let removeNumberString : String = lunchArray[1].components(separatedBy: CharacterSet.decimalDigits).joined()
                        let removeDotString : String = removeNumberString.replacingOccurrences(of: ".", with: "")
                        self.todayLunchLabel.text = removeDotString
                    }else{
                        self.todayLunchLabel.text = "해당 날짜는 급식이 없습니다"
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
    
    
    struct Lunch: Codable {
        let mealServiceDietInfo: [MealServiceDietInfo]
    }

    struct MealServiceDietInfo: Codable {
        let row: [Row]?
        
    }
    struct Row : Codable {
        let ddishNm : String
        
        enum CodingKeys: String, CodingKey {
            case ddishNm = "DDISH_NM"
        }
        
        
    }
}
