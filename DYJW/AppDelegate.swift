//
//  AppDelegate.swift
//  DYJW
//
//  Created by 风筝 on 16/9/12.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit
import RealmSwift

let app = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do {
            try Realm.setup()
        } catch {
            print("Setup Realm failed: \(error)")
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPod Touch" {
            let storyboard = UIStoryboard(name: "iPhoneMain", bundle: Bundle.main)
            storyboard.instantiateInitialViewController()
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
        } else if UIDevice.current.model == "iPad" {
            let storyboard = UIStoryboard(name: "iPhoneMain", bundle: Bundle.main)
            storyboard.instantiateInitialViewController()
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
        } else {
            let storyboard = UIStoryboard(name: "iPhoneMain", bundle: Bundle.main)
            storyboard.instantiateInitialViewController()
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        let animationView = LaunchAnimationView.loadFromNib()
        animationView.show(in: self.window)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}

