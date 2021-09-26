//
//  TimetableViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class TimetableViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let todayDate = Date()
    let formatter = DateFormatter()
    let userData = ["Grade":"3","Class":"6","Number":"20"]
    
    var timelist = [String]()
    var thisMondayDate = String()
    var thisFridayDate = String()
    
    var nextMondayDate = String()
    var nextFridayDate = String()
    
    @IBOutlet weak var collectionview : UICollectionView!
    
    override func viewDidLoad() {
        let flowlayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        flowlayout.scrollDirection = .horizontal
        flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.minimumLineSpacing = 5
        
        let cellWidthSize = collectionview.bounds.size.width / 6
        let cellHeightSize = collectionview.bounds.size.height / 8
        
        flowlayout.itemSize = CGSize(width: cellWidthSize, height: cellHeightSize)
        
        self.collectionview.collectionViewLayout = flowlayout
        
        
        makeThisWeek()
        setTimetableData()
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
    }
    
    
    func setTimetableData(){
        let url = "https://open.neis.go.kr/hub/hisTimetable?Type=json&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010537&KEY=406a6783d8db4d5483fd44abf25d720f&GRADE=3&CLASS_NM=6&TI_FROM_YMD="+self.thisMondayDate+"&TI_TO_YMD="+self.thisFridayDate
        
        AF.request(url,
                   method: .get).responseJSON{
                    response in
                    let json = JSON(response.data)
                    let jTimetable = json["hisTimetable"].arrayValue[1]
                    let row = jTimetable["row"]
                    
                    if let arr = row.array{
                        for i in 0..<arr.count {
                            self.timelist.append(arr[i]["ITRT_CNTNT"].stringValue)
                            // arr[i] = arr[i].replacingOccurrences(of: "* ", with: "")
                        }
                    }
                    self.collectionview.reloadData()
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timelist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TimeCollectionViewCell
        
        cell.timeLabel.text = timelist[indexPath.row]
        
        
        
        return cell
    }
    
    func makeThisWeek(){
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko-KR")
        let thisday = formatter.string(from: todayDate)
        exonerationThisWeekMondayAndFriday(thisday: thisday)
    }
    
    func exonerationThisWeekMondayAndFriday(thisday : String){
        let thisdaies = ["월","화","수","목","금","토","일"]
        
        let todayIndex = Int(thisdaies.firstIndex(of: thisday) ?? 0)
        let Monday = Calendar.current.date(byAdding: .day,value: -todayIndex, to: todayDate)
        formatter.dateFormat = "yyyyMMdd"
        let mondayDate = formatter.string(from: Monday!)
        
        self.thisMondayDate = mondayDate
        
        var fridayDate = String()
        
        if todayIndex <= 4{
            let timeDifference = 4 - todayIndex
            let Friday = Calendar.current.date(byAdding: .day, value: timeDifference, to: todayDate)
            formatter.dateFormat = "yyyyMMdd"
            fridayDate = formatter.string(from: Friday!)
            
            self.thisFridayDate = fridayDate
        }else{
            let timeDifference = todayIndex - 4
            let friday = Calendar.current.date(byAdding: .day, value: -timeDifference, to: todayDate)
            formatter.dateFormat = "yyyyMMdd"
            fridayDate = formatter.string(from: friday!)
            
            self.thisFridayDate = fridayDate
        }
        
    }
    
    func makeNextWeek(){
        formatter.dateFormat = "yyyyMMdd"
        let nextMonday = Calendar.current.date(byAdding: .day, value: 7, to: formatter.date(from: thisMondayDate) ?? todayDate)
        let nextFriday = Calendar.current.date(byAdding: .day, value: 7, to: formatter.date(from: thisFridayDate) ?? todayDate)
        self.nextMondayDate = formatter.string(from: nextMonday!)
        self.nextFridayDate = formatter.string(from: nextFriday!)
    }
    
    @IBAction func dismissView(){
        dismiss(animated: true)
    }
    
}
