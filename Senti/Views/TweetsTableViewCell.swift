//
//  TweetsTableViewCell.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    private lazy var containerView = UIView()
    private lazy var profileImageView = UIImageView()
    private lazy var verifiedIconImageView = UIImageView()
    private lazy var usernameLabel = UILabel()
    private lazy var createdAtLabel = UILabel()
    private lazy var tweetLabel = UILabel()
    
    var tweets: Tweet? {
        didSet {
            guard let tweet = tweets else { return }
    
            usernameLabel.text = tweet.user?.screen_name
            createdAtLabel.text = tweet.created_at?.formatDate()
            tweetLabel.text = tweet.text
            
            if let verified = tweet.user?.verified {
                verifiedIconImageView.image = verified ? #imageLiteral(resourceName: "icon_verified") :  nil
            }
            
            if let picture = tweet.user?.profile_image_url_https {
                profileImageView.loadAndCacheImage(from: picture, key: picture)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupComponents()
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    fileprivate func setupComponents() {
        containerView.setupWith(color: .appBaseLight, radius: 12)
        profileImageView.setupWith(contentMode: .scaleAspectFill, radius: 24)
        usernameLabel.setupWith(font: .boldSystemFont(ofSize: 16), textColor: .appIceWhite)
        verifiedIconImageView.setupWith(contentMode: .scaleAspectFit)
        createdAtLabel.setupWith(font: .systemFont(ofSize: 14, weight: .light), textColor: .appIceWhite)
        tweetLabel.setupWith(font: .systemFont(ofSize: 16, weight: .medium), textColor: .appIceWhite, numberOfLines: 0)
    }
}


// MARK: Auto Layout
extension TweetsTableViewCell {
    
    fileprivate func setupUI() {
        contentView.backgroundColor = .appBaseDark
        
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        containerView.addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        containerView.addSubview(usernameLabel)
        usernameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        
        containerView.addSubview(verifiedIconImageView)
        verifiedIconImageView.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 8).isActive = true
        verifiedIconImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16).isActive = true
        verifiedIconImageView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        verifiedIconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        verifiedIconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        containerView.addSubview(createdAtLabel)
        createdAtLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4).isActive = true
        createdAtLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        createdAtLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        
        containerView.addSubview(tweetLabel)
        tweetLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 16).isActive = true
        tweetLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        tweetLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        tweetLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32).isActive = true
    }
}
