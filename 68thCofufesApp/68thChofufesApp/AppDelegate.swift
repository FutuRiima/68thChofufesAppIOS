//
//  AppDelegate.swift
//  68thCofufesApp
//
//  Created by 麻生未来 on 2018/10/01.
//  Copyright © 2018年 68thChofufes. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let cGoogleMapsAPIKey = "AIzaSyDZwf5nBjyw6MUvzkZkQ7uA-lk-u-anyCE"
    
    var cameraCheck: Bool?
    
    let QRCountMax: Int = 3 //おまけ券使用回数制限
    var QRCount: Int?
    var QRText: String?
    
    let omake = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let userDefault = UserDefaults.standard
        let dict = ["firstLaunch":true]
        userDefault.register(defaults: dict)
        
        if userDefault.bool(forKey: "firstLaunch"){  //初回起動処理
            userDefault.set(false, forKey: "firstLaunch")
            QRCount = QRCountMax
            omake.set(QRCount, forKey: "omake")
            print("初回起動のみ実行される")
            
        }
        
        print("初回起動でなくても実行される")
        FirebaseApp.configure()
        QRCount = omake.integer(forKey: "omake")
        GMSServices.provideAPIKey(cGoogleMapsAPIKey)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        omake.set(QRCount, forKey: "omake")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        omake.set(QRCount, forKey: "omake")
    }


}

