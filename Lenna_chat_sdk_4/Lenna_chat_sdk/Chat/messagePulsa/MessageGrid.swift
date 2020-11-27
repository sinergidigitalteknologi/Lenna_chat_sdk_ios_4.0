//
//  MessageGrid.swift
//  Lenna
//
//  Created by MacBook Air on 3/18/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit
protocol PulsaDelegate {
    func BeliPulsa(data: String)
}

class MessageGrid: UITableViewCell,  UICollectionViewDelegate, UICollectionViewDataSource   {
    
    @IBOutlet weak var gridImage: UICollectionView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var arrGrid = [ColumnGrid]()
    
    var pulsaDelegate : PulsaDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.gridImage.dataSource = self
        self.gridImage.delegate = self
        self.gridImage.register(UINib.init(nibName: "MessageGridCell", bundle: nil), forCellWithReuseIdentifier: "messageGridId")
        
        let layout = self.gridImage.collectionViewLayout as! UICollectionViewFlowLayout
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        layout.itemSize = CGSize(width: width / 4, height: 100)
    
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return arrGrid.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gridItem = arrGrid[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageGridId", for: indexPath as IndexPath) as! MessageGridCell
   
        cell.title.text = String(gridItem.text)
        cell.subTitle.text = gridItem.subText
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(arrGrid[indexPath.item])
        
        if arrGrid[indexPath.item].defaultAction.type == "postback" {
            pulsaDelegate?.BeliPulsa(data: arrGrid[indexPath.item].text)
        }
        
    }
    
}

