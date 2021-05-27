//
//  ContainerTableViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/05/27.
//

import UIKit

class ContainerTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    let cellIdentifier : String = "timetableCell"
    var timetableList : Array<String> = Array<String>()
    
    @IBOutlet weak var timeTableview : UITableView!
    
    override func viewDidLoad() {
        self.timeTableview.dataSource = self
        self.timeTableview.delegate = self
        print(timetableList)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = timeTableview.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = timetableList[indexPath.row]
        
        return cell
    }
    
}
