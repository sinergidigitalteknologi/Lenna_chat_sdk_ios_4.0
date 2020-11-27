//
//  CustomImageView.swift
//  Lenna_chat
//
//  Created by MacBook Air on 10/29/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft, .topRight], radius: 10)
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
            let maskPath = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            layer.mask = shape
    }
    
}
