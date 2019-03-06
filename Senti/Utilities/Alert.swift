//
//  Alert.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

struct Alert {
    private init() {}
    
    enum AlertTitle: String {
        case error = "Ooops!"
    }
    
    enum AlertMessage: String {
        case userNotFound = "We could not find the Twitter user you were looking for. Please, check the username and try again!"
    }
    
    enum AlertAction: String {
        case ok = "Ok"
        case cancel = "Cancel"
    }
    
    static func with(error: Error) -> UIAlertController {
        DispatchQueue.main.async { Lottie.hide() }
        let alert = UIAlertController(title: AlertTitle.error.rawValue, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertAction.ok.rawValue, style: .default, handler: nil))
        return alert
    }
    
    static func with(title: AlertTitle, message: AlertMessage) -> UIAlertController {
        DispatchQueue.main.async { Lottie.hide() }
        let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertAction.ok.rawValue, style: .default, handler: nil))
        return alert
    }

    static func with(title: AlertTitle) -> UIAlertController {
        DispatchQueue.main.async { Lottie.hide() }
        let alert = UIAlertController(title: title.rawValue, message: "", preferredStyle: .alert)
        return alert
    }

    static func with(title: AlertTitle, message: AlertMessage, action: AlertAction, cancel: Bool, style: UIAlertAction.Style, completion: @escaping ()->()) -> UIAlertController {
        DispatchQueue.main.async { Lottie.hide() }
        let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action.rawValue, style: style, handler: { (action) in
            completion()
        }))
        if cancel {
            alert.addAction(UIAlertAction(title: AlertAction.cancel.rawValue, style: .cancel, handler: nil))
        }
        return alert
    }
}
