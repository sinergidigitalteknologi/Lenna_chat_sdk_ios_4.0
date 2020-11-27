//
//  FormCell.swift
//  Lenna
//
//  Created by MacBook Air on 4/30/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell {

    @IBOutlet weak var formTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
