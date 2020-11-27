//
//  MessageMovie.swift
//  Lenna
//
//  Created by MacBook Air on 3/18/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

protocol MessageMovieDetailDelegate {
    func movieUrl(dataMovie : DataMovie)
}

class MessageMovie: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , MovieButtonDelegate  {    
    @IBOutlet weak var carouselImage: UICollectionView!
    
    var arrMovieCarousel = [ColumnMovieCarousel]()
    
    var movieDetailDelegate : MessageMovieDetailDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.carouselImage.dataSource = self
        self.carouselImage.delegate = self
        self.carouselImage.register(UINib.init(nibName: "MoviewCell", bundle: nil), forCellWithReuseIdentifier: "messageMovieId")
        
//        let layout = self.carouselImage.collectionViewLayout as! UICollectionViewFlowLayout
//        let width = UIScreen.main.bounds.width
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        layout.minimumLineSpacing = 15
//        layout.minimumInteritemSpacing = 15
//        
//        layout.itemSize = CGSize(width: (width - 13) / (3/2), height: 350
//        )

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMovieCarousel.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movieInfo = arrMovieCarousel[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageMovieId", for: indexPath as IndexPath) as! MoviewCell
        
        cell.movieImage.sd_setImage(with: URL(string: movieInfo.thumbnailImageUrl), completed: nil)
        cell.movieImage.layer.masksToBounds = true
        cell.movieImage.layer.cornerRadius = 12
        cell.movieImage.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
//        cell.title.text = movieInfo.title
        
        cell.movieImage.animationDuration = 1.5
        cell.movieImage.startAnimating()
        
        cell.arrBtn = movieInfo.actions
        
        cell.movieBtn = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let safeDelegate = self.movieDetailDelegate {
            safeDelegate.movieUrl(dataMovie: arrMovieCarousel[indexPath.row].actions[0].data)
        }
    }
    
    func MovieButton(dataMovie: DataMovie) {
        if let safeDelegate = self.movieDetailDelegate {
            safeDelegate.movieUrl(dataMovie: dataMovie)
        }
    }

    
}

