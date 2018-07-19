//
//  AppDelegate.swift
//  LongPomo-ios
//
//  Created by Daniel Vela on 08/02/2018.
//  Copyright © 2018 Daniel Vela. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static func get() -> AppDelegate {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate
        }
        return AppDelegate()
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        configureAppearance()
        LongPomoNotificationManager.shared.askPermission()
        return true
    }

    func configureAppearance() {
        UIView.appearance().backgroundColor = AppColors.backgroundColor
        UIButton.appearance().tintColor = AppColors.primaryColor
        UIButton.appearance().setTitleColor(AppColors.primaryColor, for: .normal)
        UILabel.appearance().textColor = AppColors.primaryColor
    }

    func applicationWillResignActive(_ application: UIApplication) {
        RestorationManager.appDeactivated()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate
        // timers, and store enough application state information to restore your
        // application to its current state in case it is terminated later.
        // If your application supports background execution, this method is
        // called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active
        // state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        RestorationManager.appActivated()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate.
        // See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
