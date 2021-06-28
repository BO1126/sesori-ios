//
//  StudentUIView.swift
//  sesori
//
//  Created by 이정우 on 2021/06/27.
//

import UIKit

class StudentUIView: UIView {

    let cornerView = UIView()
    
    override func draw(_ rect: CGRect) {
        cornerView.layer.cornerRadius = 15
        cornerView.layer.masksToBounds = true
    }
    
}
