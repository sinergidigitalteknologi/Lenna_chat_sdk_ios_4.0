//
//  WeatherCell.swift
//  Lenna
//
//  Created by MacBook Air on 5/6/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var daelabel: UILabel!
    @IBOutlet weak var TopImageDay: UIImageView!
    @IBOutlet weak var topImageNight: UIImageView!
    @IBOutlet weak var topDayWeatherLabel: UILabel!
    @IBOutlet weak var topNightWeatherLabel: UILabel!
    @IBOutlet weak var topMinTempLabel: UILabel!
    @IBOutlet weak var topMaxTempLabel: UILabel!
    @IBOutlet weak var topLabelTemp: UILabel!
    
    @IBOutlet weak var day1: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var day3: UILabel!
    @IBOutlet weak var day4: UILabel!
    @IBOutlet weak var day5: UILabel!
    
    @IBOutlet weak var daytemp1: UILabel!
    @IBOutlet weak var daytemp2: UILabel!
    @IBOutlet weak var daytemp3: UILabel!
    @IBOutlet weak var daytemp4: UILabel!
    @IBOutlet weak var daytemp5: UILabel!
    
    @IBOutlet weak var nighttemp1: UILabel!
    @IBOutlet weak var nighttemp2: UILabel!
    @IBOutlet weak var nighttemp3: UILabel!
    @IBOutlet weak var nighttemp4: UILabel!
    @IBOutlet weak var nighttemp5: UILabel!
    
    @IBOutlet weak var dayimage1: UIImageView!
    @IBOutlet weak var dayimage2: UIImageView!
    @IBOutlet weak var dayimage3: UIImageView!
    @IBOutlet weak var dayimage4: UIImageView!
    @IBOutlet weak var dayimage5: UIImageView!
    
    @IBOutlet weak var nightimage1: UIImageView!
    @IBOutlet weak var nightimage2: UIImageView!
    @IBOutlet weak var nightimage3: UIImageView!
    @IBOutlet weak var nightimage4: UIImageView!
    @IBOutlet weak var nightimage5: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
}
