//
//  CustomAlertController.swift
//  Lenna
//
//  Created by Agustiar on 5/14/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

protocol confirmMessageDelegate {
    func confirmdelegate(newMessage: String)
}

class ConfirmationCustomAlertController: UIViewController {
    
    @IBOutlet weak var confirmationAlertView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var iconAlert: UIImageView!
    
    @IBOutlet weak var titleAlert: UILabel!
    @IBOutlet weak var messageAlert: UILabel!
    
    var titleText = String()
    var messageText = String()
    var buttonAction: (() -> Void)?
    var alertHeader = String()
    
    var confirmDelegate : confirmMessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        headerView.layer.cornerRadius = 10
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        confirmationAlertView.layer.cornerRadius = 10
        round()
    }
    
    func round(){
        
    }
    
    func setupView(){
        titleAlert.text = titleText
        messageAlert.text = messageText
        headerView.backgroundColor = UIColor.init(named: alertHeader)
        
    }
    
    @IBAction func confirmationYes(_ sender: UIButton) {
        confirmDelegate?.confirmdelegate(newMessage: "Ya")
        buttonAction?()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmationNo(_ sender: UIButton) {
        confirmDelegate?.confirmdelegate(newMessage: "Tidak")
        dismiss(animated: true, completion: nil)
    }
}
