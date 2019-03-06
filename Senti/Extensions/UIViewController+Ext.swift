//
//  UIViewController+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

public var cache = NSCache<AnyObject, AnyObject>()

extension UIViewController {
    
    func setupNavBar(with title: String? = nil) {
        if let title = title { navigationItem.title = title }
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.accessibilityLabel = Constants.Accessibility.backButton
    }
}
