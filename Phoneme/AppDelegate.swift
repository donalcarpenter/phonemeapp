//
//  AppDelegate.swift
//  Phoneme
//
//  Created by donal on 23/07/2015.
//  Copyright (c) 2015 donal. All rights reserved.
//

import UIKit
import Parse


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Parse.enableLocalDatastore()
        
        let keysPath: String? = Bundle.main.path(forResource: "key2", ofType: "plist")
        
        if(keysPath == nil){
            NSLog("Pleae add key2.plist file with parseAppId and parseClientId")
            return false
        }
        
        let keys = NSDictionary(contentsOfFile: keysPath!)!
    
        let appId: String = keys["parseAppId"] as! String
        // let clientId: String = keys["parseClientId"] as! String
        
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = appId
            $0.server = "https://phonemeapplive.herokuapp.com/parse"
        }
        
        Parse.initialize(with: configuration)
        
        for family in UIFont.familyNames {
            NSLog("\(family)")
            for name in UIFont.fontNames(forFamilyName: family){
                NSLog("    \(name)")
            }
        }
        
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
    }


}

