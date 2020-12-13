//
//  ButtonCarousel.swift
//  Lenna
//
//  Created by MacBook Air on 3/21/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class ButtonCarousel: UITableViewCell {

    @IBOutlet weak var btnAction: UIButton!
    
    var userInterfaceStyle : UIUserInterfaceStyle?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            if #available(iOS 13.0, *) {
                layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
                contentView.backgroundColor = UIColor.secondarySystemBackground
                btnAction.backgroundColor = .secondarySystemBackground
            } else {
                // Fallback on earlier versions
                layer.backgroundColor = UIColor.white.cgColor
                 contentView.backgroundColor = UIColor.white
                btnAction.backgroundColor = .white
            }
            layer.borderWidth = 0
            print("dark mode")
        }else {
            layer.backgroundColor = UIColor.white.cgColor
             contentView.backgroundColor = UIColor.white
            btnAction.backgroundColor = .brown
            print("light mode")
        }
        btnAction.titleLabel?.lineBreakMode = .byWordWrapping
        btnAction.titleLabel?.textAlignment = .center
       
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let userInterfaceStyle1 = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        // Update your user interface based on the appearance
        
        if #available(iOS 13.0, *) {
            
            if userInterfaceStyle1 == .dark {
                layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
                 contentView.backgroundColor = UIColor.secondarySystemBackground
                btnAction.backgroundColor = .secondarySystemBackground
                print("dark mode")
                
            } else {
                print("light mode")
                layer.backgroundColor = UIColor.white.cgColor
                 contentView.backgroundColor = UIColor.white
                btnAction.backgroundColor = .white
            }
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
