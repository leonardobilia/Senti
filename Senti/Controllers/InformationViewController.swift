//
//  InformationViewController.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/6/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    private lazy var scoreTitleLabel = UILabel()
    private lazy var scoreDescriptionLabel = UILabel()
    private lazy var scoreStackView = UIStackView()
    
    private lazy var magnitudeTitleLabel = UILabel()
    private lazy var magnitudeDescriptionLabel = UILabel()
    private lazy var magnitudeStackView = UIStackView()
    
    private lazy var infoStackView = UIStackView()
    
    private lazy var logoImageView = UIImageView()
    private lazy var copyrightLabel = UILabel()
    private lazy var versionLabel = UILabel()
    private lazy var footerStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(with: Constants.Info.title)
        setupNavBarItems()
        setupComponents()
        setupUI()
    }
    
    @objc fileprivate func dimissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupNavBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_dismiss"), style: .plain, target: self, action: #selector(dimissButtonTapped))
        navigationItem.rightBarButtonItem?.accessibilityLabel = Constants.Accessibility.dismiss
    }
    
    fileprivate func setupComponents() {
        scoreTitleLabel.setupWith(text: Constants.Info.scoreTitle, font: .boldSystemFont(ofSize: 24), textColor: .appIceWhite)
        scoreDescriptionLabel.setupWith(text: Constants.Info.scoreDescription, font: .systemFont(ofSize: 16, weight: .medium), textColor: .appIceWhite, numberOfLines: 0)
        scoreStackView.setupWith(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 16)
        
        magnitudeTitleLabel.setupWith(text: Constants.Info.magnitudeTitle, font: .boldSystemFont(ofSize: 24), textColor: .appIceWhite)
        magnitudeDescriptionLabel.setupWith(text: Constants.Info.magnitudeDescription, font: .systemFont(ofSize: 16, weight: .medium), textColor: .appIceWhite, numberOfLines: 0)
        magnitudeStackView.setupWith(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 16)
    
        infoStackView.setupWith(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 48)
        
        logoImageView.setupWith(image: #imageLiteral(resourceName: "main_icon"), contentMode: .scaleAspectFit)
        copyrightLabel.setupWith(text: Constants.Info.copyright, font: .systemFont(ofSize: 14, weight: .light), textColor: .appIceWhite, numberOfLines: 0, alignment: .center)
        versionLabel.setupWith(text: Constants.appVersion(), font: .boldSystemFont(ofSize: 16), textColor: .appIceWhite, alignment: .center)
        footerStackView.setupWith(axis: .vertical, alignment: .center, spacing: 16)
    }
}


// MARK: Auto Layout
extension InformationViewController {
    fileprivate func setupUI() {
        view.backgroundColor = .appBaseDark
        
        view.addSubview(infoStackView)
        infoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        infoStackView.addArrangedSubview(scoreStackView)
        infoStackView.addArrangedSubview(magnitudeStackView)
        
        scoreStackView.addArrangedSubview(scoreTitleLabel)
        scoreStackView.addArrangedSubview(scoreDescriptionLabel)
        
        magnitudeStackView.addArrangedSubview(magnitudeTitleLabel)
        magnitudeStackView.addArrangedSubview(magnitudeDescriptionLabel)
        
        view.addSubview(footerStackView)
        footerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        footerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        footerStackView.addArrangedSubview(logoImageView)
        footerStackView.addArrangedSubview(copyrightLabel)
        footerStackView.addArrangedSubview(versionLabel)
        
        logoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
