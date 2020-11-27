//
//  MessageForm.swift
//  Lenna
//
//  Created by MacBook Air on 3/11/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class MessageForm: UITableViewCell {
    
    let messageLabel = UILabel()
    let bubleBackgroundView = UIImageView()
    let bubbleImage = UIImage(named: "bubble_received")?
        .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                        resizingMode: .stretch)
        .withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    let messageTime = UILabel()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        //        bubleBackgroundView.backgroundColor = .yellow
        //        bubleBackgroundView.layer.cornerRadius = 12
        //        bubleBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMinXMaxYCorner , .layerMaxXMinYCorner]
        bubleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubleBackgroundView.tintColor = UIColor.init(named: "#f6f7f8")
        addSubview(bubleBackgroundView)
        
        messageLabel.text = "Open Form"
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "SFProText-Regular", size: 16)!
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageLabel)
        messageTime.numberOfLines = 0
        
        messageTime.textAlignment = .left
        
        messageTime.font = UIFont(name: "Quicksand-Regular", size: 13)!
        
        messageTime.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageTime)
        
        //lets set up some constraints for our label
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            messageLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -10),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            messageTime.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            messageTime.widthAnchor.constraint(equalTo: messageLabel.widthAnchor),
            
            messageTime.leadingAnchor.constraint(equalTo: bubleBackgroundView.leadingAnchor, constant: 20),
            
            bubleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            bubleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bubleBackgroundView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 8),
            bubleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 20),
            
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: bubleBackgroundView.leadingAnchor, constant: 20)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: bubleBackgroundView.trailingAnchor, constant: -20)
        trailingConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
