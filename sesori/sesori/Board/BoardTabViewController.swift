//
//  BoardTabViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/10/20.
//

import UIKit
import Tabman
import Pageboy

class BoardTabViewController: TabmanViewController {
    
    @IBOutlet weak var tabView : UIView!

    private var viewControllers: Array<UIViewController> = []

        override func viewDidLoad() {
            super.viewDidLoad()

            let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vc1") as! BoardTab1ViewController
            
            let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vc2") as! BoardTab2ViewController
            
            let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vc3") as! BoardTab3ViewController
            
            viewControllers.append(vc1)
            viewControllers.append(vc2)
            viewControllers.append(vc3)
            
            self.dataSource = self

            // Create bar
            let bar = TMBar.ButtonBar()
            bar.layout.transitionStyle = .snap // Customize

            // Add to view
            addBar(bar, dataSource: self, at: .custom(view: tabView, layout: nil))
            
            bar.indicator.overscrollBehavior = .bounce
            bar.indicator.tintColor = UIColor(red: 104/255, green: 180/255, blue: 1, alpha: 1)
            bar.buttons.customize { (button) in
                button.tintColor = .lightGray
                button.selectedTintColor = UIColor(red: 104/255, green: 180/255, blue: 1, alpha: 1)
            }
            
            bar.backgroundView.style = .clear
            bar.layout.alignment = .centerDistributed
        }
    
    
}

extension BoardTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        let arr = ["전체","공지","기타"]
        item.title = "\(arr[index])"
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
