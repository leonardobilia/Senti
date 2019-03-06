//
//  TweetsViewController.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TweetsViewController: UIViewController {

    private lazy var tableView = UITableView()
    private lazy var disposeBag = DisposeBag()
    private lazy var tweetsViewModel = TweetsViewModel()
    
    var username = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(with: Constants.Tweets.title)
        setupTableView()
        tweetsViewModel.delegate = self
        fetchTweets()
    }

    // MARK: Functions
    fileprivate func fetchTweets() {
        tweetsViewModel.fetchTweet(from: username) { [weak self] in
            self?.setupCellConfiguration()
        }
    }
    
    fileprivate func setupCellConfiguration() {
        let tweet = Observable.just(tweetsViewModel.tweets)
        tweet.bind(to: tableView.rx.items(cellIdentifier: TweetsTableViewCell.reuseIdentifier, cellType: TweetsTableViewCell.self)) { row, tweet, cell in
            cell.tweets = tweet
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Tweet.self).subscribe(onNext: { (tweet) in
            print(tweet.text ?? "Nope")
        }).disposed(by: disposeBag)
    }

    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .appBaseDark
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TweetsTableViewCell.self, forCellReuseIdentifier: TweetsTableViewCell.reuseIdentifier)
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


// MARK: TweetsViewModelDelegate
extension TweetsViewController: TweetsViewModelDelegate {
    func presentView(controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
}
