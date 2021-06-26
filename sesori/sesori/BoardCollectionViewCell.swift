//
//  BoardCollectionViewCell.swift
//  sesori
//
//  Created by 이정우 on 2021/06/21.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boardTabbarLabel : UILabel!
    
    override var isSelected: Bool{
        willSet{
            if newValue{
                boardTabbarLabel.textColor = .black
            }else{
                boardTabbarLabel.textColor = .lightGray
            }
        }
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
}
