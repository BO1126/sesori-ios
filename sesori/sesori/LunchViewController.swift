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
    let ddishNm, orplcInfo: String

    enum CodingKeys: String, CodingKey {
        case ddishNm = "DDISH_NM"
        case orplcInfo = "ORPLC_INFO"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ddishNm = (try? values.decode(String.self, forKey: .ddishNm))!
        orplcInfo = (try? values.decode(String.self, forKey: .orplcInfo))!
    }
    
}

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
                   method: .get).responseJSON{
                    response in
                    let decoder = JSONDecoder()
                    let lunch = try? decoder.decode(Lunch.self, from: response.data!)
                    let lunchdata = "\(String(describing: lunch))"
                    self.convertLunchText(todaylunch: lunchdata)
                    print(lunch!)
                   }
    }
    
    
    func convertLunchText(todaylunch : String){
        var converter : String = todaylunch
        converter = converter.replacingOccurrences(of: "<br/>", with: "\n")
        self.TodayLunchLabel.text = converter
    }
    
    
}
