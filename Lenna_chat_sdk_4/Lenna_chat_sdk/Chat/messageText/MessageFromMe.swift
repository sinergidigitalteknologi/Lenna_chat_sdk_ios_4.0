//
//  MessageFromMe.swift
//  Lenna
//
//  Created by MacBook Air on 2/12/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class MessageFromMe: UITableViewCell {
    
//    @IBOutlet weak var chatMe: UILabel!
//    @IBOutlet weak var time: UILabel!
//    @IBOutlet weak var chatContainer: UIView!
    

    let messageLabel = UILabel()
    let bubleBackgroundView = UIImageView()
    let bubbleImage = UIImage(named: "bubble_me")?
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
//        bubleBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMinXMaxYCorner , .layerMinXMinYCorner]
        bubleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubleBackgroundView.tintColor = #colorLiteral(red: 0, green: 0.4549019608, blue: 0.6862745098, alpha: 1)
        
        addSubview(bubleBackgroundView)
        
        messageLabel.text = "We want to provide a longer string that is actually going to wrap onto the next line and maybe even a third line"
        messageLabel.numberOfLines = 0
        
        messageLabel.font = UIFont(name: "SFProText-Regular", size: 16)!
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageLabel)
        
//        messageTime.text = "08:00 am"
        messageTime.numberOfLines = 0
        
        messageTime.textAlignment = .right
        
        messageTime.font = UIFont(name: "SFProText-Regular", size: 13)!
        
        messageTime.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageTime)
        
        let width = UIScreen.main.bounds.width
        
        //lets set up some constraints for our label
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant:15),
            messageLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -10),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: width - 100),
            
            messageTime.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            messageTime.widthAnchor.constraint(equalTo: messageLabel.widthAnchor),
            messageTime.trailingAnchor.constraint(equalTo: bubleBackgroundView.trailingAnchor, constant: -20),
            
            bubleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            bubleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -20),
            bubleBackgroundView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 8),
            bubleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
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
