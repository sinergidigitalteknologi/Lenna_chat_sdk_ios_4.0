//
//  MoviewCell.swift
//  Lenna
//
//  Created by MacBook Air on 3/18/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

protocol MovieButtonDelegate {
    func MovieButton(dataMovie : DataMovie)
}

class MoviewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var movieImage: UIImageView!
//    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var btnCell: UITableView!
    
    var arrBtn = [ActionMovie]()
    
    var movieBtn : MovieButtonDelegate?
    
    var userInterfaceStyle : UIUserInterfaceStyle?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnCell.delegate = self
        btnCell.dataSource = self
        btnCell.register(UINib(nibName: "BtnMovie", bundle: nil), forCellReuseIdentifier: "BtnMovie")
        
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            if #available(iOS 13.0, *) {
                layer.cornerRadius = 12
                contentView.layer.cornerRadius = 12
                contentView.layer.borderColor = UIColor.clear.cgColor
                contentView.layer.masksToBounds = true
                
                layer.backgroundColor = UIColor.secondarySystemBackground.cgColor


            } else {
           
                layer.cornerRadius = 12
                
                contentView.layer.cornerRadius = 12
                contentView.layer.borderColor = UIColor.clear.cgColor
                contentView.layer.masksToBounds = true
                
                layer.backgroundColor = UIColor.white.cgColor

            }
            layer.borderWidth = 0
            print("dark mode")
        }else {
            layer.cornerRadius = 12
            contentView.layer.cornerRadius = 12
            contentView.layer.borderWidth = 0.7
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.masksToBounds = true
            
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0.75)
            layer.shadowRadius = 3
            layer.shadowOpacity = 0.7
            layer.masksToBounds = false
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
            layer.backgroundColor = UIColor.white.cgColor

        }

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let userInterfaceStyle1 = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        // Update your user interface based on the appearance
        
        if #available(iOS 13.0, *) {
            
            if userInterfaceStyle1 == .dark {
                layer.cornerRadius = 12
                print("dark mode")
                
                contentView.layer.cornerRadius = 12
                contentView.layer.borderColor = UIColor.clear.cgColor
                contentView.layer.masksToBounds = true
                
              
                layer.backgroundColor = UIColor.secondarySystemBackground.cgColor

                
            } else {
                print("light mode")
                layer.cornerRadius = 12
                
                contentView.layer.cornerRadius = 12
                contentView.layer.borderWidth = 0.7
                contentView.layer.borderColor = UIColor.clear.cgColor
                contentView.layer.masksToBounds = true
                
                layer.shadowColor = UIColor.lightGray.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 0.75)
                layer.shadowRadius = 3
                layer.shadowOpacity = 0.7
                layer.masksToBounds = false
                layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
                layer.backgroundColor = UIColor.white.cgColor

            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BtnMovie", for: indexPath) as! BtnMovie
        
        cell.btnDetail.setTitle(arrBtn[indexPath.item].label, for: .normal)
        cell.btnDetail.tag = indexPath.row
        
        cell.btnDetail.addTarget(self, action: #selector(detailTapped), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieBtn?.MovieButton(dataMovie: arrBtn[0].data)
    }

    @objc func detailTapped(sender: UIButton) {
        movieBtn?.MovieButton(dataMovie: arrBtn[0].data)
    }

}
