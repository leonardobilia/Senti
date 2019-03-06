//
//  AnalysisViewController.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/6/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnalysisViewController: UIViewController {

    private lazy var emojiContainer = UIView()
    private lazy var emojiLabel = UILabel()
    
    private lazy var scoreContainer = UIView()
    private lazy var scoreTitle = UILabel()
    private lazy var scoreResult = UILabel()
    private lazy var scoreStackView = UIStackView()
    
    private lazy var magnitudeContainer = UIView()
    private lazy var magnitudeTitle = UILabel()
    private lazy var magnitudeResult = UILabel()
    private lazy var magnitudeStackView = UIStackView()
    
    private lazy var mainStackView = UIStackView()
    
    private lazy var analysisViewModel = AnalysisViewModel()
    private let disposeBag = DisposeBag()
    var tweet = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(with: Constants.Analysis.title)
        setupNavBarItems()
        setupComponents()
        setupUI()
        
        analysisViewModel.delegate = self
        setupSubscribers()
        fetchAnalysis()
    }
    
    @objc fileprivate func infoButtonTapped() {
        analysisViewModel.infoHandler()
    }
    
    fileprivate func fetchAnalysis() {
        analysisViewModel.fetchAnalysis(for: tweet) { [weak self] in
            self?.analysisViewModel.sentimentHandler()
        }
    }
    
    fileprivate func setupSubscribers() {
        analysisViewModel.emojiText.asObservable().bind(to: emojiLabel.rx.text).disposed(by: disposeBag)
        analysisViewModel.scoreText.asObservable().bind(to: scoreResult.rx.text).disposed(by: disposeBag)
        analysisViewModel.magnitudeText.asObservable().bind(to: magnitudeResult.rx.text).disposed(by: disposeBag)
        
        analysisViewModel.emojiContainerColor.asObservable().bind { [weak self] (color) in
            DispatchQueue.main.async { self?.emojiContainer.backgroundColor = color }
        }.disposed(by: disposeBag)
    }
    
    fileprivate func setupNavBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_info-1"), style: .plain, target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem?.accessibilityLabel = Constants.Accessibility.info
    }
    
    fileprivate func setupComponents() {
        emojiContainer.setupWith(color: .appBaseLight, radius: 100, corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
        emojiLabel.setupWith(font: .boldSystemFont(ofSize: 120), textColor: .appIceWhite)

        scoreContainer.setupWith(color: .appBaseLight, radius: 12)
        scoreTitle.setupWith(text: Constants.Analysis.score, font: .systemFont(ofSize: 16, weight: .medium), textColor: .appIceWhite, alignment: .center)
        scoreResult.setupWith(font: .boldSystemFont(ofSize: 32), textColor: .appIceWhite, alignment: .center)
        scoreStackView.setupWith(axis: .vertical, spacing: 0)
        
        magnitudeContainer.setupWith(color: .appBaseLight, radius: 12)
        magnitudeTitle.setupWith(text: Constants.Analysis.magnitude, font: .systemFont(ofSize: 16, weight: .medium), textColor: .appIceWhite, alignment: .center)
        magnitudeResult.setupWith(font: .boldSystemFont(ofSize: 32), textColor: .appIceWhite, alignment: .center)
        magnitudeStackView.setupWith(axis: .vertical, spacing: 0)
        
        mainStackView.setupWith(axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 16)
    }
}



// MARK: AnalysisViewModelDelegate
extension AnalysisViewController: AnalysisViewModelDelegate {
    func presentView(controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
}


// MARK: Auto Layout
extension AnalysisViewController {
    fileprivate func setupUI() {
        view.backgroundColor = .appBaseDark
        
        view.addSubview(mainStackView)
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        mainStackView.addArrangedSubview(scoreContainer)
        mainStackView.addArrangedSubview(magnitudeContainer)
        
        scoreContainer.addSubview(scoreStackView)
        scoreStackView.centerXAnchor.constraint(equalTo: scoreContainer.centerXAnchor).isActive = true
        scoreStackView.centerYAnchor.constraint(equalTo: scoreContainer.centerYAnchor).isActive = true
        scoreStackView.addArrangedSubview(scoreTitle)
        scoreStackView.addArrangedSubview(scoreResult)
        
        magnitudeContainer.addSubview(magnitudeStackView)
        magnitudeStackView.centerXAnchor.constraint(equalTo: magnitudeContainer.centerXAnchor).isActive = true
        magnitudeStackView.centerYAnchor.constraint(equalTo: magnitudeContainer.centerYAnchor).isActive = true
        magnitudeStackView.addArrangedSubview(magnitudeTitle)
        magnitudeStackView.addArrangedSubview(magnitudeResult)
        
        view.addSubview(emojiContainer)
        emojiContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        emojiContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emojiContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emojiContainer.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -16).isActive = true
        
        emojiContainer.addSubview(emojiLabel)
        emojiLabel.centerXAnchor.constraint(equalTo: emojiContainer.centerXAnchor).isActive = true
        emojiLabel.centerYAnchor.constraint(equalTo: emojiContainer.centerYAnchor).isActive = true
    }
}
