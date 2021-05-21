//
//  LunchViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/19.
//

import UIKit
import Alamofire

struct Lunch: Codable {
    let mealServiceDietInfo: [MealServiceDietInfo]
}

struct MealServiceDietInfo: Codable {
    let row: [Row]?
}
struct Row: Codable {
    let ddishNm : String

    enum CodingKeys: String, CodingKey {
        case ddishNm = "DDISH_NM"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ddishNm = (try? values.decode(String.self, forKey: .ddishNm))!
    }
    
}

class LunchViewController : UIViewController {
    
    @IBOutlet weak var todayLunchLabel : UILabel!
    @IBOutlet weak var lunchDatePicker : UIDatePicker!
    
    override func viewDidLoad() {
        getLunchData(pickDate: "20210521")
    }
    
    @IBAction func didLunchDatePickerValueChanged(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let userPickDate = formatter.string(from: lunchDatePicker.date)
        getLunchData(pickDate: userPickDate)
    }
    
    func getLunchData(pickDate : String){
        
        let url = "https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&pIndex=1&pSize=1&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010537&MLSV_YMD="+pickDate+"&KEY=406a6783d8db4d5483fd44abf25d720f"
        
        AF.request(url,
                   method: .get).responseJSON{
                    response in
                    let decoder = JSONDecoder()
                    let lunch = try? decoder.decode(Lunch.self, from: response.data!)
                    let lunchdata = "\(String(describing: lunch))"
                    self.convertLunchText(todaylunch: lunchdata)
                   }
    }
    
    
    func convertLunchText(todaylunch : String){
        var converter : String = todaylunch
        converter = converter.replacingOccurrences(of: "<br/>", with: "\n")
        let arr = converter.components(separatedBy: "\"")
        if arr[0] == "nil" {
            converter = "해당 날짜는 급식이 없습니다!"
        }
        else if arr[1] != nil{
            converter = arr[1]
        }
        self.todayLunchLabel.text = converter
    }
    
    
}
