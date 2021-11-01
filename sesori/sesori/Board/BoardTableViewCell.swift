//
//  BoardTableViewCell.swift
//  sesori
//
//  Created by 이정우 on 2021/10/10.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    @IBOutlet weak var writerNameLabel: UILabel!
    @IBOutlet weak var writeDateLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
