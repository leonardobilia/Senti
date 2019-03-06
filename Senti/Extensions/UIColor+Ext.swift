//
//  UIColor+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    static let appBaseDark = UIColor(r: 32, g: 36, b: 45, a: 1)
    static let appBaseLight = UIColor(r: 43, g: 49, b: 62, a: 1)
    static let appIceWhite = UIColor(r: 248, g: 248, b: 248, a: 1)
    static let appLightBlue = UIColor(r: 0, g: 170, b: 236, a: 1)
    static let appNeutral = UIColor(r: 155, g: 155, b: 155, a: 1)
    static let appPositive = UIColor(r: 255, g: 211, b: 42, a: 1)
    static let appNegative = UIColor(r: 74, g: 144, b: 226, a: 1)
}
