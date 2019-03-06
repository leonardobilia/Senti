//
//  AppDelegate.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupNavigationBarStyle()
        Twitter.sharedInstance().start(withConsumerKey: Constants.TwitterKit.consumerKey, consumerSecret: Constants.TwitterKit.consumerSecret)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        
        return true
    }

    fileprivate func setupNavigationBarStyle() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.appIceWhite, .font: UIFont.boldSystemFont(ofSize: 20)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.appIceWhite, .font: UIFont.boldSystemFont(ofSize: 34)]
        UINavigationBar.appearance().barTintColor = UIColor.appBaseDark
        UINavigationBar.appearance().tintColor = UIColor.appIceWhite
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "icon_back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon_back")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

