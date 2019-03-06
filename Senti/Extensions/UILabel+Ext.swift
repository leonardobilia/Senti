//
//  UILabel+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setupWith(text: String? = nil, font: UIFont, textColor: UIColor, numberOfLines: Int? = nil, alignment: NSTextAlignment? = nil, adjustsFontSize: Bool? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.font = font
        self.textColor = textColor
        
        if let text = text {
            self.text = text
        }
        
        if let numberOfLines = numberOfLines {
            self.numberOfLines = numberOfLines
        }
        
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        
        if let adjustsFontSize = adjustsFontSize {
            self.adjustsFontSizeToFitWidth = adjustsFontSize
        }
    }
}

