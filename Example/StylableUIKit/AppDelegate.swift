//
//  AppDelegate.swift
//  StylableUIKit
//
//  Created by atomoil on 01/18/2019.
//  Copyright (c) 2019 atomoil. All rights reserved.
//

import UIKit
import StylableUIKit

private func isUnderTest() -> Bool {
    return Bundle.allBundles.map { $0.bundlePath }.contains { $0.hasSuffix(".xctest") }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // If we are in a test we shouldn't load the UI - it affects the code coverage.
        if isUnderTest() {
            let window = UIWindow()
            self.window = window
            let controller = UIViewController()
            controller.view.backgroundColor = .green
            window.rootViewController = controller
            window.makeKeyAndVisible()
            return true
        }

        let stylist = AppStylist()

        if let tab = window?.rootViewController as? UITabBarController,
            let viewControllers = tab.viewControllers {

            zip(viewControllers, Section.allCases).forEach {
                $0.style(stylist: stylist, section: $1)
            }
        }

        return true
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
