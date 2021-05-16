//
//  AppDelegate.swift
//  Cipher
//
//  Created by Дмитрий on 5/12/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // - Window
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        window?.makeKeyAndVisible()
        return true
    }

}

