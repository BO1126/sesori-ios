//
//  TemporaryLoginWaitViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/11/20.
//

import UIKit

class TemporaryLoginWaitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            sleep(1)
            let view = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
            view?.modalTransitionStyle = .coverVertical
            view?.modalPresentationStyle = .fullScreen
            self.present(view!, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
