//
//  TimetableViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/21.
//

import UIKit

class TimetableViewController : UIViewController {
    let todaydate = Date()
    let formatter = DateFormatter()
    override func viewDidLoad() {
        makeThisWeek()
    }
    
    func makeThisWeek(){
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko-KR")
        let thisday = formatter.string(from: todaydate)
        exonerationThisWeekMondayAndFriday(thisday: thisday)
        print(thisday)
    }
    
    func exonerationThisWeekMondayAndFriday(thisday : String){
        let thisdaies = ["월","화","수","목","금","토","일"]
        
        let todayIndex = Int(thisdaies.firstIndex(of: thisday) ?? 0)
        let Monday = Calendar.current.date(byAdding: .day,value: -todayIndex, to: todaydate)
        formatter.dateFormat = "yyyyMMdd"
        let mondayDate = formatter.string(from: Monday!)
        
        if todayIndex <= 4{
            let timeDifference = 4 - todayIndex
            let Friday = Calendar.current.date(byAdding: .day, value: timeDifference, to: todaydate)
            formatter.dateFormat = "yyyyMMdd"
            let fridayDate = formatter.string(from: Friday!)
            
            print(fridayDate)
        }else{
            let timeDifference = todayIndex - 4
            let Friday = Calendar.current.date(byAdding: .day, value: -timeDifference, to: todaydate)
            formatter.dateFormat = "yyyyMMdd"
            let fridayDate = formatter.string(from: Friday!)
            
            print(fridayDate)
        }
        
        print(mondayDate)
    }
    
}
