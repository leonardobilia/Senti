//
//  AnalysisViewModel.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/6/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AnalysisViewModelDelegate: AnyObject {
    func presentView(controller: UIViewController)
}

class AnalysisViewModel {
    
    var emojiText = BehaviorRelay<String>(value: "")
    var emojiContainerColor = BehaviorRelay<UIColor>(value: .appBaseLight)
    var scoreText = BehaviorRelay<String>(value: "")
    var magnitudeText = BehaviorRelay<String>(value: "")

    private var webservice = Services()
    private var analysis: SentimentAnalysis?
    weak var delegate: AnalysisViewModelDelegate?
    
    func sentimentHandler() {
        guard let score = analysis?.documentSentiment.score, let magnitude = analysis?.documentSentiment.magnitude else { return }
        
        switch score {
        case score where score > -1.0 && score < -0.25: sentimentBinder("😔", score, magnitude, .appNegative)
        case score where score > 0.25 && score < 1.0: sentimentBinder("😃", score, magnitude, .appPositive)
        default: sentimentBinder("😐", score, magnitude, .appNeutral)
        }
    }
    
    fileprivate func sentimentBinder(_ emoji: String, _ score: Double, _ magnitude: Double, _ color: UIColor) {
        emojiText.accept(emoji)
        scoreText.accept(String(score))
        magnitudeText.accept(String(magnitude))
        emojiContainerColor.accept(color)
    }
    
    func infoHandler() {
        let controller = InformationViewController()
        delegate?.presentView(controller: UINavigationController(rootViewController: controller))
    }
}


// MARK: Network
extension AnalysisViewModel {
    
    func fetchAnalysis(for tweet: String, completion: @escaping () -> ()) {
        Lottie.show(.spinner, size: 400)
        webservice.fetchGoogleAnalysis(with: tweet) { [weak self] (analysis, error) in
            if let error = error {
                self?.delegate?.presentView(controller: Alert.with(error: error))
                return
            }
            self?.analysis = analysis
            DispatchQueue.main.async { Lottie.hide() }
            completion()
        }
    }
}
