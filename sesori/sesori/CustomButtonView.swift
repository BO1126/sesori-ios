//
//  CustomButtonView.swift
//  sesori
//
//  Created by 이정우 on 2021/06/27.
//

import UIKit

class CustomButtonView : UIView {
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var cornerView : UIView!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        private func commonInit(){
            let bundle = Bundle(for: CustomButtonView.self)
            bundle.loadNibNamed("CustomButtonView", owner: self, options: nil)
            addSubview(customView)
            customView.frame = self.bounds
            customView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            customView.layer.borderWidth = 1
            customView.layer.cornerRadius = 20
            customView.layer.masksToBounds = true
            customView.layer.shadowOpacity = 1
            customView.layer.shadowRadius = 7
            
            cornerView.layer.cornerRadius = 15
            cornerView.layer.masksToBounds = true
            
            
        }
}
