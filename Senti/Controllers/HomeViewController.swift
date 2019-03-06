//
//  HomeViewController.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .appLightBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var topImageView = UIImageView()
    private lazy var twitterImageView = UIImageView()
    private lazy var searchContainerView = UIView()
    private lazy var searchTextField = UITextField()
    private lazy var searchButton = UIButton()
    private lazy var stackView = UIStackView()
    
    private var searchContainerBottomAnchor: NSLayoutConstraint?
    private var homeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupComponents()
        setupCollectionView()
        setupUI()
        setupSubscribers()
        fetchSummary()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        returnKeyboard()
        homeViewModel.removeKeyboardObserver()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    @objc fileprivate func returnKeyboard() {
        homeViewModel.returnKeyboard(textField: searchTextField)
    }
    
    @objc fileprivate func serachButtonTapped() {
        homeViewModel.delegate = self
        guard let username = searchTextField.text else { return }
        homeViewModel.analyzeTweetsFrom(username)
        searchTextField.text = nil
    }
    
    fileprivate func fetchSummary() {
        let summary = Observable.just(homeViewModel.summary)
        summary.bind(to: collectionView.rx.items(cellIdentifier: SummaryCollectionViewCell.reuseIdentifier, cellType: SummaryCollectionViewCell.self)) { index, summary, cell in
            cell.summary = summary
        }.disposed(by: disposeBag)
        pageControl.numberOfPages = homeViewModel.summary.count
    }
    
    fileprivate func setupSubscribers() {
        homeViewModel.anchor.subscribe { [weak self] (constant) in
            self?.searchContainerBottomAnchor?.constant = constant.element ?? 0
        }.disposed(by: disposeBag)
        
        homeViewModel.isLayoutNeeded.subscribe { [weak self] (isLayoutNeeded) in
            if isLayoutNeeded.element ?? false { self?.view.layoutIfNeeded() }
        }.disposed(by: disposeBag)
        
        searchTextField.rx.text.subscribe(onNext: { [weak self] (username) in
            guard let username = username else { return }
            self?.searchButton.isEnabled = username.validateTwitterUsername() ? true : false
            self?.twitterImageView.tintColor = username.validateTwitterUsername() ? .appLightBlue : .red
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupComponents() {
        view.backgroundColor = .appBaseDark
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnKeyboard)))

        searchTextField.delegate = self
        searchTextField.setupWith(placeholder: Constants.Home.searchTextFieldPlaceholder)
        twitterImageView.tintColor = .appLightBlue
        twitterImageView.setupWith(image: #imageLiteral(resourceName: "icon_twitter"), contentMode: .scaleAspectFit)
        topImageView.setupWith(image: #imageLiteral(resourceName: "main_icon"), contentMode: .scaleAspectFit)
        searchContainerView.setupWith(color: .appBaseLight, radius: 32, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        stackView.setupWith(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 8)
        searchButton.setupWith(title: Constants.Home.searchButtonTitle, corner: 29, color: .appLightBlue, accessibility: Constants.Accessibility.search, target: self, action: #selector(serachButtonTapped))
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.backgroundColor = .appBaseDark
        collectionView.register(SummaryCollectionViewCell.self, forCellWithReuseIdentifier: SummaryCollectionViewCell.reuseIdentifier)
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


// MARK: UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func pushView(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: Auto Layout
extension HomeViewController {
    
    fileprivate func setupUI() {
        view.addSubview(topImageView)
        topImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topImageView.widthAnchor.constraint(equalToConstant: 76).isActive = true
        topImageView.heightAnchor.constraint(equalToConstant: 106).isActive = true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 48).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        view.addSubview(pageControl)
        pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(searchContainerView)
        searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchContainerBottomAnchor = searchContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        searchContainerBottomAnchor?.isActive = true
        
        searchContainerView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: searchContainerView.topAnchor, constant: 32).isActive = true
        stackView.centerXAnchor.constraint(equalTo: searchContainerView.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: -32).isActive = true
        
        stackView.addArrangedSubview(searchTextField)
        searchTextField.widthAnchor.constraint(equalToConstant: 255).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 58).isActive = true

        stackView.addArrangedSubview(searchButton)
        searchButton.widthAnchor.constraint(equalToConstant: 255).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 58).isActive = true

        searchContainerView.addSubview(twitterImageView)
        twitterImageView.centerXAnchor.constraint(equalTo: searchTextField.leadingAnchor).isActive = true
        twitterImageView.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
        twitterImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        twitterImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

