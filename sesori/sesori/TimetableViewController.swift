//
//  TimetableViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/21.
//

import UIKit
import Alamofire


class TimetableViewController : UIViewController, XMLParserDelegate {
    let todayDate = Date()
    let formatter = DateFormatter()
    let userData = ["Grade":"3","Class":"6","Number":"20"]
    
    override func viewDidLoad() {
        makeThisWeek()
        getTimetableData()
    }
    
    func makeThisWeek(){
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko-KR")
        let thisday = formatter.string(from: todayDate)
        exonerationThisWeekMondayAndFriday(thisday: thisday)
        print(thisday)
    }
    
    func exonerationThisWeekMondayAndFriday(thisday : String){
        let thisdaies = ["월","화","수","목","금","토","일"]
        
        let todayIndex = Int(thisdaies.firstIndex(of: thisday) ?? 0)
        let Monday = Calendar.current.date(byAdding: .day,value: -todayIndex, to: todayDate)
        formatter.dateFormat = "yyyyMMdd"
        let mondayDate = formatter.string(from: Monday!)
        
        print(mondayDate)
        
        if todayIndex <= 4{
            let timeDifference = 4 - todayIndex
            let Friday = Calendar.current.date(byAdding: .day, value: timeDifference, to: todayDate)
            formatter.dateFormat = "yyyyMMdd"
            let fridayDate = formatter.string(from: Friday!)
            
            print(fridayDate)
        }else{
            let timeDifference = todayIndex - 4
            let Friday = Calendar.current.date(byAdding: .day, value: -timeDifference, to: todayDate)
            formatter.dateFormat = "yyyyMMdd"
            let fridayDate = formatter.string(from: Friday!)
            
            print(fridayDate)
        }
        
    }
    
    
    func getTimetableData(){
        let url = "https://open.neis.go.kr/hub/hisTimetable?Type=json&pIndex=1&pSize=10&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010537&KEY=406a6783d8db4d5483fd44abf25d720f&GRADE=3&CLASS_NM=6&ALL_TI_YMD=20210526"
        AF.request(url,
                   method: .get).responseJSON{
                    response in
                    let decoder = JSONDecoder()
                    let timetable = try? decoder.decode(Timetable.self, from: response.data!)
                    let timetableData = "\(String(describing: timetable))"
                    self.convertTimetableText(timetableData: timetableData)
                   }
        
    }
    
    func convertTimetableText(timetableData : String){
        let converter = timetableData
        let arr = converter.components(separatedBy: "\"")
        var i : Int = 0
        while true {
            i+=1
            if i%2==1 {
                print(arr[i])
                if (arr.count - 2) <= i {
                    break
                }
            }
            
        }
    }
    
    struct Timetable: Codable {
        let hisTimetable: [HisTimetable]
    }
    
    
    struct HisTimetable: Codable {
        let row: [Row]?
    }
    
    
    struct Row: Codable {
        let perio: String
        let itrtCntnt: String
        
        enum CodingKeys: String, CodingKey {
            case perio = "PERIO"
            case itrtCntnt = "ITRT_CNTNT"
        }
    }
    
}
