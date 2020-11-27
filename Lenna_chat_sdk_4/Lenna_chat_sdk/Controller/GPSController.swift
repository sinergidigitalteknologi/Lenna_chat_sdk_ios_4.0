//
//  GPSController.swift
//  Lenna_chat_sdk_4
//
//  Created by MacBook Air on 11/26/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import UIKit

class GPSController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func gps(_ sender: Any) {

           UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
       }
   
}

