//
//  CustomDatePicker.swift
//  Lenna
//
//  Created by Agustiar on 6/3/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import Foundation
import UIKit

protocol CustomDateDelegate: AnyObject {
    func datePickerValue(dateData: String)
}

class CustomDatePickerController: UIViewController {
    
    @IBOutlet weak var datePickerHeaderView: UIView!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateString = ""
    
    var delegate: CustomDateDelegate? = nil
    
    var buttonAction: (() -> Void)?
    
    override func viewDidLoad() {
        datePickerView.layer.cornerRadius = 10
        datePickerHeaderView.layer.cornerRadius = 10
        datePickerHeaderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        dateString = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        buttonAction?()
        self.delegate?.datePickerValue(dateData: dateString)
        dismiss(animated: true, completion: nil)
    }
    
   
    
}
