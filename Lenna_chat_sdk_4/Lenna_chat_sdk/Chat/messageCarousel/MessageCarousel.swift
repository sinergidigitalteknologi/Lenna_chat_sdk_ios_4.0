//
//  MessageCarousel.swift
//  Lenna
//
//  Created by MacBook Air on 2/18/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit
import SDWebImage

protocol CarouselButtonMessageDelegate {
    func CarouselMessageButton (newMessage: String)
}


class MessageCarousel: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, CarouselButtonDelegate {
    
    @IBOutlet weak var carouselImage: UICollectionView!
    
    var arrCarousel = [ColumnCarousel]()
    
    var btnMessageDelegate : CarouselButtonMessageDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.carouselImage.dataSource = self
        self.carouselImage.delegate = self
        self.carouselImage.register(UINib.init(nibName: "CarouselViewCell", bundle: nil), forCellWithReuseIdentifier: "carouselViewID")
        
        
//        let layout = self.carouselImage.collectionViewLayout as! UICollectionViewFlowLayout
//        let width = UIScreen.main.bounds.width
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        layout.minimumLineSpacing = 20
//        layout.minimumInteritemSpacing = 20
//        
//        layout.itemSize = CGSize(width: (width - 13) / (3/2), height: 355)
        
       

    }
    
    func CarouselButton(newMessage: String) {
        print("MessageCarousel CarouselButton", newMessage)
        btnMessageDelegate?.CarouselMessageButton(newMessage: newMessage)
    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCarousel.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataCarousel = arrCarousel[indexPath.item]
        print("MessageCarousel->",dataCarousel);
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselViewID", for: indexPath as IndexPath) as! CarouselViewCell
        
        cell.imageArrayCarousel.sd_setImage(with: URL(string: dataCarousel.thumbnailImageUrl), completed: nil)
        
        cell.imageArrayCarousel.layer.masksToBounds = true
        cell.imageArrayCarousel.layer.cornerRadius = 12
        cell.imageArrayCarousel.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
        let clear_text = dataCarousel.title.replacingOccurrences(of: "<br>", with: "")
        cell.title.text = clear_text

        cell.btnDelegate = self
        
        cell.arrAction = dataCarousel.actions
        cell.btnList.rowHeight = CGFloat(80/cell.arrAction.count)
        
        cell.btnList.reloadData()
    
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("MessageCarousel->2",arrCarousel[indexPath.item])
    }
    

}

