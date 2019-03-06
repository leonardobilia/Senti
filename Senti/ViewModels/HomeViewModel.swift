//
//  HomeViewModel.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeViewModelDelegate: AnyObject {
    func pushView(controller: UIViewController)
}

class HomeViewModel {

    var summary = [
        Summary(message: Constants.Home.message1),
        Summary(message: Constants.Home.message2),
        Summary(message: Constants.Home.message3)
    ]
    
    var anchor = BehaviorRelay<CGFloat>(value: 0)
    var isLayoutNeeded = BehaviorRelay<Bool>(value: false)
    
    weak var delegate: HomeViewModelDelegate?
    
    func returnKeyboard(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardNotification(notification: NSNotification) {
        handleKeyboard(notification: notification)
    }
    
    fileprivate func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            let constant = isKeyboardShowing ? (-keyboardFrame.height) : 0
            anchor.accept(constant)
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                self?.isLayoutNeeded.accept(true)
            }) { (completed) in }
        }
    }
    
    func analyzeTweetsFrom(_ username: String) {
        let controller = TweetsViewController()
        controller.username = username
        delegate?.pushView(controller: controller)
    }
}
