//
//  UIStackView+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func setupWith(axis: NSLayoutConstraint.Axis? = nil, distribution: UIStackView.Distribution? = nil, alignment: UIStackView.Alignment? = nil, spacing: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let axis = axis {
            self.axis = axis
        }
        
        if let distribution = distribution {
            self.distribution = distribution
        }
        
        if let alignment = alignment {
            self.alignment = alignment
        }
        
        if let spacing = spacing {
            self.spacing = spacing
        }
    }
}
