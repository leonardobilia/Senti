//
//  TweetsViewModel.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol TweetsViewModelDelegate: AnyObject {
    func pushView(controller: UIViewController)
    func presentView(controller: UIViewController)
}

class TweetsViewModel {
    
    var tweets: [Tweet] = []
    private var webservice = Services()
    weak var delegate: TweetsViewModelDelegate?
    
    func didSelect(tweet: String) {
        let controller = AnalysisViewController()
        controller.tweet = tweet
        delegate?.pushView(controller: controller)
    }
}

// MARK: Network
extension TweetsViewModel {

    func fetchTweet(from username: String, completion: @escaping (Error?) -> ()) {
        Lottie.show(.spinner, size: 400)
        webservice.fetchTweets(from: username) { [weak self] (data, error) in
            if let error = error {
                completion(error)
                Lottie.hide()
                return
            }
            guard let data = data else { return }
            self?.tweets = data.filter({ $0.lang == "en"}).compactMap({ $0 })
            completion(nil)
            Lottie.hide()
        }
    }
}
