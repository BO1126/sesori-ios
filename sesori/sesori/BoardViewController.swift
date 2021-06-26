//
//  BoardViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/06/21.
//

import UIKit

class BoardViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionview : UICollectionView!
    let topTabbar = ["공지사항","익명 커뮤니티"]
    
    override func viewDidLoad() {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 0
        let cellWidthSize = collectionview.bounds.size.width / (CGFloat(topTabbar.count) + 1)
        let cellHeightSize = collectionview.bounds.size.height
        
        flowlayout.itemSize = CGSize(width: cellWidthSize, height: cellHeightSize)
        collectionview.collectionViewLayout = flowlayout
        
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topTabbar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "Boardcell", for: indexPath) as! BoardCollectionViewCell
        
        cell.boardTabbarLabel.text = topTabbar[indexPath.row]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }
    
}
