//
//  UITableView+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func setupEmptyTableView(with title: String, subtitle: String, image: UIImage) {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        
        let topImageView = UIImageView()
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        let stackView = UIStackView()
        
        topImageView.setupWith(image: image, contentMode: .scaleAspectFit)
        titleLabel.setupWith(text: title, font: .boldSystemFont(ofSize: 24), textColor: .appIceWhite, numberOfLines: 0, alignment: .center)
        subtitleLabel.setupWith(text: subtitle, font: .systemFont(ofSize: 16, weight: .light), textColor: .appIceWhite, numberOfLines: 0, alignment: .center)
        stackView.setupWith(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 16)
        
        container.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        
        stackView.addArrangedSubview(topImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        backgroundView = container
    }
    
    func removeEmptyTableView() {
        backgroundView = nil
    }
}
