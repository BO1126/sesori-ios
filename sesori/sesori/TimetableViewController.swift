//
//  TimetableViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/21.
//

import UIKit
import Alamofire

class TimetableViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let todayDate = Date()
    let formatter = DateFormatter()
    let userData = ["Grade":"3","Class":"6","Number":"20"]
    
    var timelist = [String]()
    
    @IBOutlet weak var collectionview : UICollectionView!
    
    override func viewDidLoad() {
        makeThisWeek()
        getTimetableData()
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
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
                    let arr = timetableData.components(separatedBy: "\"")
                    
                    var i = 0
                    var timetableList = Array<String>()
                    
                    while true {
                        i+=1
                        if i%2==1 {
                            timetableList.append(arr[i])
                            if (arr.count - 2) <= i {
                                break
                            }
                        }
                    }
                    
                    self.timelist = timetableList
                    print(self.timelist)
                   }
        
    }
    
    func convertTimetableText(timetableData : String) -> Array<String>{
        var timetableList : Array<String> = Array<String>()
        var li : Array<String> = Array<String>()
        
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
        var j=0
        while true {
            j+=1
            if j%2==1 {
                li.append(timetableList[j])
                if (timetableList.count-1) <= j {
                    break
                }
            }
        }
        return li
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timelist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TimeCollectionViewCell
        
        cell.timeLabel.text = timelist[indexPath.row]
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
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
