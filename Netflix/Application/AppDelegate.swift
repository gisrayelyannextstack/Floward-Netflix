//
//  AppDelegate.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootController()
        return true
    }

    //MARK: Setup root controller
    private func setupRootController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeController()
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.barTintColor = .appBackground
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textPrimaryColor]
        nav.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
}

