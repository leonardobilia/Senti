//
//  UIView+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

extension UIView {
    
    func setupWith(color: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
    }
    
    func setupWith(color: UIColor, radius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = radius
        layer.masksToBounds = true
        backgroundColor = color
    }
    
    func setupWith(color: UIColor, radius: CGFloat, corners: CACornerMask) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.masksToBounds = true
    }
}
