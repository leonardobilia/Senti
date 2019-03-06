//
//  UIButton+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

extension UIButton {
    
    static private var originalButtonText: String?
    static private var activityIndicator: UIActivityIndicatorView!
    
    func setupWith(title: String, corner: CGFloat, color: UIColor, accessibility: String, target: Any? = nil, action: Selector? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(.appIceWhite, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = corner
        layer.masksToBounds = true
        backgroundColor = color
        accessibilityLabel = accessibility
        
        if let target = target, let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }

    func showLoading() {
        UIButton.originalButtonText = titleLabel?.text
        setTitle("", for: .normal)
        isEnabled = false
        if UIButton.activityIndicator == nil {
            UIButton.activityIndicator = createActivityIndicator()
        }
        showActivityIndicator()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.setTitle(UIButton.originalButtonText, for: .normal)
            self.isEnabled = true
            if UIButton.activityIndicator != nil {
                UIButton.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        return activityIndicator
    }
    
    private func showActivityIndicator() {
        UIButton.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(UIButton.activityIndicator)
        centerActivityIndicatorInButton()
        UIButton.activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        UIButton.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        UIButton.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
