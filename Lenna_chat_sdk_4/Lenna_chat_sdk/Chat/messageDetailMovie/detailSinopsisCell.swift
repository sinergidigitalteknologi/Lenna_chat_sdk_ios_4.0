//
//  detailSinopsisCell.swift
//  Lenna
//
//  Created by MacBook Air on 5/7/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class detailSinopsisCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrTime = [String]()

    @IBOutlet weak var collectionTime: UICollectionView!
    @IBOutlet weak var btnPesan: UIButton!
    @IBOutlet weak var startslabel: UILabel!
    @IBOutlet weak var sinopsisLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionTime.dataSource = self
        collectionTime.delegate = self
        collectionTime.register(UINib.init(nibName: "movieTimeCell", bundle: nil), forCellWithReuseIdentifier: "movieTimeCell")

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : movieTimeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieTimeCell", for: indexPath) as! movieTimeCell
        
        cell.time.text = arrTime[indexPath.item]
        
        return cell
    }

    
    

}
