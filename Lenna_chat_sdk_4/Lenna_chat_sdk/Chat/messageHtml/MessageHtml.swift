//
//  MessageHtml.swift
//  Lenna
//
//  Created by MacBook Air on 5/29/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit
import WebKit

class MessageHtml: UITableViewCell {

    
   
    @IBOutlet weak var htmlData: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
