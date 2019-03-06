//
//  UICollectionView+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit
import Foundation

extension UICollectionViewCell {
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
