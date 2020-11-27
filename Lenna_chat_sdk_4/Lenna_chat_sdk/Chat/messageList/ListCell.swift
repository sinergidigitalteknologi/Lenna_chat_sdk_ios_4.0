//
//  ListCell.swift
//  Lenna
//
//  Created by MacBook Air on 7/8/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var priceList: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
