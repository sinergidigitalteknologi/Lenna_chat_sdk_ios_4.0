//
//  MessageText.swift
//  Lenna
//
//  Created by MacBook Air on 25/10/20.
//  Copyright © 2020 sdtech. All rights reserved.
//

import UIKit

class MessageText: UITableViewCell {

//    @IBOutlet weak var chatText: UILabel!
    
    let messageLabel = UILabel()
    let bubleBackgroundView = UIImageView()
    let bubbleImage = UIImage(named: "bubble_received2")?
        .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                        resizingMode: .stretch)
    let bubbleImage_dark = UIImage(named: "bubble_received_dark")?
     .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                           resizingMode: .stretch)
    let cImage = UIImage(named: Constan.LOGO_BUBLE_CHAT)?
           .resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
                           resizingMode: .stretch)
    let messageTime = UILabel()
    let imageCircle = UIImageView()
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bubleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubleBackgroundView)
        addSubview(imageCircle)
        
        messageLabel.text = "..."
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "SFProText-Regular", size: 16)!
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        //image circle
//        imageCircle.layer.masksToBounds = false
//        imageCircle.layer.cornerRadius = 25
//        imageCircle.layoutMargins =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right:10)

//        let containerView = UIView(frame: CGRect(x:0,y:0,width:50,height:50))
//        imageCircle.frame.size = CGSize(width: containerView.frame.width,                 height:containerView.frame.height )
//        imageCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50)
        
        addSubview(messageLabel)
        messageTime.numberOfLines = 0
        messageTime.textAlignment = .left
        messageTime.font = UIFont(name: "SFProText-Regular", size: 13)!
        messageTime.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageTime)

        //lets set up some constraints for our label
        
        let width = UIScreen.main.bounds.width
        
        let constraints = [
            
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            messageLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -10),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: width - 100),
            
            messageTime.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            messageTime.widthAnchor.constraint(equalTo: messageLabel.widthAnchor),
            messageTime.leadingAnchor.constraint(equalTo: bubleBackgroundView.leadingAnchor, constant: 20),
            
            bubleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            bubleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            bubleBackgroundView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 8),
            bubleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 20),
           
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: bubleBackgroundView.leadingAnchor, constant: 10)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: bubleBackgroundView.trailingAnchor, constant: -20)
        trailingConstraint.isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
