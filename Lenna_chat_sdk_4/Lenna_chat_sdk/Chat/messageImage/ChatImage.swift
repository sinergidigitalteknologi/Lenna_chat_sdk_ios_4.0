//
//  ChatImage.swift
//  Lenna
//
//  Created by MacBook Air on 2/11/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

class ChatImage: UITableViewCell {

//    @IBOutlet weak var chatImage: UIImageView!
    let messageImage = UIImageView()
    let bubleBackgroundView = UIView()
    let bubbleImage = UIImage(named: "bubble_received")?
        .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                        resizingMode: .stretch)
        .withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    let messageTime = UILabel()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatImageController : ChatViewController?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
//        bubleBackgroundView.backgroundColor = .lightGray
        bubleBackgroundView.layer.cornerRadius = 12
        bubleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubleBackgroundView)
        
        addSubview(messageImage)
        //        messageImage.backgroundColor = .green
//        messageImage.text = "We want to provide a longer string that is actually going to wrap onto the next line and maybe even a third line"
//        messageImage.numberOfLines = 0
        
        //        messageImage.font = UIFont(name:"Avenir Next Reguler",size:15)
        messageImage.contentMode = .scaleAspectFill
        
        messageImage.translatesAutoresizingMaskIntoConstraints = false
        
        messageImage.image = nil
        
        //lets set up some constraints for our label
        let constraints = [
            messageImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            messageImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
//            messageImage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubleBackgroundView.topAnchor.constraint(equalTo: messageImage.topAnchor, constant: -1),
            bubleBackgroundView.leadingAnchor.constraint(equalTo: messageImage.leadingAnchor, constant: -1),
            bubleBackgroundView.bottomAnchor.constraint(equalTo: messageImage.bottomAnchor, constant: 1),
            bubleBackgroundView.trailingAnchor.constraint(equalTo: messageImage.trailingAnchor, constant: 1),
            bubleBackgroundView.heightAnchor.constraint(equalToConstant: 200),
            bubleBackgroundView.widthAnchor.constraint(equalToConstant: 250),
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        
        bubleBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoom)))
        
    }
    
    var startingFrame: CGRect?
    var blackBackgroundView : UIView?
    var startingImageView : UIImageView?
    
    @objc func handleZoom(tapGesture: UITapGestureRecognizer) {
        print("zoom...")
        
        self.startingImageView = messageImage
        self.startingImageView?.isHidden = true
        
        startingFrame = messageImage.superview?.convert(messageImage.frame, to: nil)
        print(startingFrame as Any)
        
        let zoomImageView = UIImageView(frame: startingFrame!)
        zoomImageView.image = messageImage.image
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        zoomImageView.isUserInteractionEnabled = true
        
        if let keyWindow = UIApplication.shared.keyWindow {
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            keyWindow.addSubview(blackBackgroundView!)
            
            keyWindow.addSubview(zoomImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                
                zoomImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                
                zoomImageView.center = keyWindow.center
                
            }) { (completed) in
//                do nothing
            }
            
        }
    }
    
    @objc
    func handleZoomOut(tapGesture: UITapGestureRecognizer) {
        print("ZOOM OUT")
        if let zoomOutImageView = tapGesture.view {
            
            zoomOutImageView.layer.cornerRadius = 12
            zoomOutImageView.clipsToBounds = true
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
                
            }) { (completed) in
                zoomOutImageView.removeFromSuperview()
                self.startingImageView?.isHidden = false
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

