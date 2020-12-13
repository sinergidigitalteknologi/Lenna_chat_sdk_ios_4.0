//
//  MessageLoading.swift
//  Lenna
//
//  Created by MacBook Air on 3/9/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit
import SDWebImage
import Lottie

class MessageLoading: UITableViewCell {

    
    let messageLabel = UILabel()
    let bubleBackgroundView = UIImageView()
    let loadingChat = SDAnimatedImageView()
    let bubbleImage = UIImage(named: "bubble_received2")?
           .resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
                           resizingMode: .stretch)
    let bubbleImage_dark = UIImage(named: "bubble_received_dark")?
    .resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
                    resizingMode: .stretch)
    let bubbleImage2 = UIImage(named: "loading")
    let loadingImage = UIImage.animatedImageNamed("loading", duration: 1.0)
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var dotLoadingIndicator: UIDotLoadingIndicator!
    
    let ss = SDAnimatedImageView()
    let animatedImage = SDAnimatedImage(named: "bubble_received2.png")
    
//    lottie
    let animationView = AnimationView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       let loading_dot = Animation.named("dot_loading")
        animationView.animation = loading_dot
        animationView.frame = CGRect(x: 10, y: 25, width: 100, height: 30)
       
        print("MessageLoading","" )         
        
        backgroundColor = .clear
        bubleBackgroundView.backgroundColor = .yellow
        bubleBackgroundView.layer.cornerRadius = 12
        bubleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        loadingChat.translatesAutoresizingMaskIntoConstraints = false
        bubleBackgroundView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addSubview(bubleBackgroundView)
        addSubview(animationView)
        addSubview(loadingChat)
        
        
        //lets set up some constraints for our label
        let constraints = [
            loadingChat.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            loadingChat.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            loadingChat.widthAnchor.constraint(lessThanOrEqualToConstant: 220),
            
            bubleBackgroundView.topAnchor.constraint(equalTo: loadingChat.topAnchor, constant: -16),
            bubleBackgroundView.leadingAnchor.constraint(equalTo: loadingChat.leadingAnchor, constant: -16),
            bubleBackgroundView.bottomAnchor.constraint(equalTo: loadingChat.bottomAnchor, constant: 16),
            bubleBackgroundView.trailingAnchor.constraint(equalTo: loadingChat.trailingAnchor, constant: 16),
            
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        //margin to parent
        leadingConstraint = loadingChat.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        
        trailingConstraint = loadingChat.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        animationView.loopMode = .loop
        animationView.play()

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
