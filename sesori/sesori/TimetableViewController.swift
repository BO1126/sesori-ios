//
//  TimetableViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/21.
//

import UIKit
import Alamofire


class TimetableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    let todayDate = Date()
    let formatter = DateFormatter()
    let userData = ["Grade":"3","Class":"6","Number":"20"]
    let cellIdentifier : String = "timetableCell"
    
    var li : Array<String> = ["1", "* 프로그래밍 언어 활용", "2", "* 프로그래밍 언어 활용", "3", "* 머신러닝 기반 데이터 분석", "4", "* 머신러닝 기반 데이터 분석", "5", "* 스마트문화앱 구현", "6", "* 스마트문화앱 구현", "7", "* 스마트문화앱 구현", "1", "성공적인 직업생활", "2", "* 머신러닝 기반 데이터 분석", "3", "* 스마트문화앱 구현", "4", "* 스마트문화앱 구현", "5", "* 빅데이터 수집", "6", "* 빅데이터 수집", "7", "* 빅데이터 수집", "1", "진로활동", "2", "* 프로그래밍 언어 활용", "3", "* 머신러닝 기반 데이터 분석", "4", "* 머신러닝 기반 데이터 분석", "5", "* 프로그래밍 언어 활용", "6", "* 프로그래밍 언어 활용", "7", "운동과 건강", "1", "* 빅데이터 수집", "2", "* 빅데이터 수집", "3", "* 프로그래밍 언어 활용", "4", "* 프로그래밍 언어 활용", "5", "* 머신러닝 기반 데이터 분석", "6", "* 머신러닝 기반 데이터 분석", "7", "성공적인 직업생활", "1", "자율활동", "2", "* 빅데이터 수집", "3", "* 스마트문화앱 구현", "4", "* 스마트문화앱 구현", "5", "자율활동", "6", "자율활동"]
    var timetableList : Array<String> = Array<String>()
    
    
    @IBOutlet weak var timeTableview : UITableView!
    
    override func viewDidLoad() {
        makeThisWeek()
        getTimetableData()
        self.timeTableview.dataSource = self
        self.timeTableview.delegate = self
        
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
        let url = "https://open.neis.go.kr/hub/hisTimetable?Type=json&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010537&KEY=406a6783d8db4d5483fd44abf25d720f&GRADE=3&CLASS_NM=6&TI_FROM_YMD=20210524&TI_TO_YMD=20210528"
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
        var i = 0
        while true {
            i+=1
            if i%2==1 {
                timetableList.append(arr[i])
                if (arr.count - 2) <= i {
                    break
                }
            }
            
        }
        print(timetableList)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return li.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = timeTableview.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = li[indexPath.row]
        
        return cell
    }
    
    
    // MARK: - decode
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
