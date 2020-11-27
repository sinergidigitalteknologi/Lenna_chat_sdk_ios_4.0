//
//  BtnList.swift
//  Lenna
//
//  Created by MacBook Air on 3/22/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class BtnList: UICollectionViewCell {

    @IBOutlet weak var ParentView: UIView!
    @IBOutlet weak var time: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func tappedTime(_ sender: UIButton) {
        
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = UIColor.init(named: "#019ecd")
            
            ParentView.backgroundColor = UIColor.init(named: "#019ecd")
            
            sender.setTitleColor(UIColor.white, for: .normal)
        }else {
            
            sender.backgroundColor = UIColor.white
            
            ParentView.backgroundColor = UIColor.white
            
            sender.setTitleColor(UIColor.init(named: "#019ecd"), for: .normal)
            
        }

    }
    
}
