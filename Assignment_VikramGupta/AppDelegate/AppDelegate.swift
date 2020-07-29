//
//  AppDelegate.swift
//  Assignment_VikramGupta
//
//  Created by Vikram Gupta on 7/23/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadRootViewController()
        // Set up check Network connection.
        setUpNetworkAvailablity()
        return true
    }
    
    // Initalize root view controller
    private func loadRootViewController() {
        let viewController = DashboardViewController(nibName: nil, bundle: nil)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barTintColor = navigationBarColor()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setUpNetworkAvailablity(){
        do {
            try NetworkManager.sharedInstance.reachability = Reachability()
            NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: NetworkManager.sharedInstance.reachability)
            try NetworkManager.sharedInstance.reachability.startNotifier()
        } catch {
            print("This is not working")
        }
    }
    
    @objc func reachabilityChanged(_ note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.connection != .unavailable {
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            print("Not reachable")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                let alert = UIAlertController(title: Message.header.rawValue, message: ApiError.networkNotAvilable.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                    alert.dismiss(animated: true, completion: nil)
                })
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

