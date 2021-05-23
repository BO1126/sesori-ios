//
//  TimetableViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/21.
//

import UIKit

class TimetableViewController : UIViewController, XMLParserDelegate {
    let todayDate = Date()
    let formatter = DateFormatter()
    let userData = ["Grade":"3","Class":"6","Number":"20"]
    
    override func viewDidLoad() {
        makeThisWeek()
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
        let url = "https://open.neis.go.kr/hub/hisTimetable?Type=&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010537&KEY=406a6783d8db4d5483fd44abf25d720f&DDDEP_NM=인공지능소프트웨어과&GRADE=3&CLASS_NM=6&TI_FROM_YMD=20210517&TI_TO_YMD=20210521"
        guard let url = URLComponents(string: url)?.url else {
            return
        }
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        parser?.parse()
        
        
    }
    
}
