//
//  UITextField+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setupWith(placeholder: String) {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 16, weight: .light)
        textColor = UIColor.appIceWhite
        autocapitalizationType = .none
        setLeftPadding(24)
        setRightPadding(16)
        setRoundedBorders(color: .appIceWhite)
        autocapitalizationType = .none
        autocorrectionType = .no
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.lightGray])
    }
    
    fileprivate func setRoundedBorders(color: UIColor) {
        layer.borderWidth = 0.5
        layer.borderColor = color.cgColor
        layer.cornerRadius = 29
        clipsToBounds = true
    }
    
    fileprivate func setLeftPadding(_ size: CGFloat){
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: frame.size.height))
        leftViewMode = .always
    }
    
    fileprivate func setRightPadding(_ size: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: frame.size.height))
        rightViewMode = .always
    }
}
