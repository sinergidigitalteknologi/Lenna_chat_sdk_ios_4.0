//
//  CustomAlertController.swift
//  Lenna
//
//  Created by Agustiar on 5/14/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class CustomAlertController: UIViewController {
    @IBOutlet weak var alertHeaderView: UIView!
    @IBOutlet weak var alertIcon: UIImageView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var alertView: UIView!
    
    var titleText = String()
    var messageText = String()
    var buttonAction: (() -> Void)?
    var alertHeader = String()
    var imageIconName = String()
    
    var idAlert = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        alertView.layer.cornerRadius = 10
        alertHeaderView.layer.cornerRadius = 10
        alertHeaderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    func setupView(){
       alertTitle.text = titleText
       alertMessage.text = messageText
       alertHeaderView.backgroundColor = UIColor.init(named: alertHeader)
       alertIcon.image = UIImage(named: imageIconName)
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        if idAlert == 0 {
            dismiss(animated: true)
        }else {
            buttonAction?()
            dismiss(animated: true)
        }
    }
    
   
}
