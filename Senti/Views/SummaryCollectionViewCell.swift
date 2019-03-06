//
//  SummaryCollectionViewCell.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {
    
    private lazy var messageLabel = UILabel()
    
    var summary: Summary? {
        didSet {
            guard let summary = summary else { return }
            messageLabel.text = summary.message
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupComponents() {
        messageLabel.setupWith(font: .systemFont(ofSize: 16, weight: .medium), textColor: .appIceWhite, numberOfLines: 0, alignment: .center)
    }
}


// MARK: Auto Layout
extension SummaryCollectionViewCell {
    
    fileprivate func setupUI() {
        addSubview(messageLabel)
        messageLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
}
