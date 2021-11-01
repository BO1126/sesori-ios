//
//  BoardViewController.swift
//  sesori
//
//  Created by 이정우 on 2021/06/21.
//

import UIKit

class BoardViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var segmentedControl : UISegmentedControl!
    
    
    override func viewDidLoad() {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 0
//        let cellWidthSize = collectionview.bounds.size.width
//        let cellHeightSize = collectionview.bounds.size.height / 3
//
//        flowlayout.itemSize = CGSize(width: cellWidthSize, height: cellHeightSize)
//        collectionview.collectionViewLayout = flowlayout
//
//        collectionview.delegate = self
//        collectionview.dataSource = self
        mainView.layer.cornerRadius = 50
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 104/255, green: 180/255, blue: 1, alpha: 1)
            ], for: .selected)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
