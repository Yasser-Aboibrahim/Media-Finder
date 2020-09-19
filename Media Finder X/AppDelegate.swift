//
//  AppDelegate.swift
//  Media Finder X
//
//  Created by yasser on 8/5/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        let userData = UserDefaultManager.shared().userEmail
        let isLogged = UserDefaultManager.shared().isLoggedIn
        
            if userData != nil {
        if  isLogged {
                print("Go to MediaList screen")
            
                let movieListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.mediaListVC) as! MediaListVC
                let navigatioController = UINavigationController(rootViewController: movieListVC)
                navigationBarColor()
                self.window?.rootViewController = navigatioController
            }else{
                print("Go to Sign in screen")
            
                let sginInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
                let navigatioController = UINavigationController(rootViewController: sginInVC)
                navigationBarColor()
                self.window?.rootViewController = navigatioController
            
                }
            }else{
                navigationBarColor()
        }
        
        return true
    }
    
    private func navigationBarColor(){
        UINavigationBar.appearance().barTintColor = .gray
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = .gray
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

