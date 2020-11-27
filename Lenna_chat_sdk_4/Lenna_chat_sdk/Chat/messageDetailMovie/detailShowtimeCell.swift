//
//  detailShowtimeCell.swift
//  Lenna
//
//  Created by MacBook Air on 5/7/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

protocol MovieTimes {
    func movieTime(time : String)
}

class detailShowtimeCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var btnPesan: UIButton!
    @IBOutlet weak var timeCollection: UICollectionView!
    
    var arrTime = [String]()
    
    var movieTimeDelegate : MovieTimes?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeCollection.dataSource = self
        timeCollection.delegate = self
        timeCollection.register(UINib.init(nibName: "movieTimeCell", bundle: nil), forCellWithReuseIdentifier: "movieTimeCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : movieTimeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieTimeCell", for: indexPath) as! movieTimeCell
        
        cell.time.text = arrTime[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        movieTimeDelegate?.movieTime(time: arrTime[indexPath.item])
        
        let currentCell = collectionView.cellForItem(at: indexPath) as! movieTimeCell
        
        if currentCell.parentView.backgroundColor == UIColor.white {
            
            currentCell.time.backgroundColor = UIColor.init(named: "#0087D3")
            
            currentCell.parentView.backgroundColor = UIColor.init(named: "#0087D3")
            
            currentCell.time.textColor = UIColor.white

        }else {
            
            currentCell.time.backgroundColor = UIColor.white
            
            currentCell.parentView.backgroundColor = UIColor.white
            
            currentCell.time.textColor = UIColor.init(named: "#0087D3")
            
        }

        
    }
    

}
