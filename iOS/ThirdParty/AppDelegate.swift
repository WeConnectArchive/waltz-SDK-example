//
//  AppDelegate.swift
//  ThirdParty
//
//  Created by Guillaume Vachon on 2018-08-14.
//  Copyright © 2018 Waltz. All rights reserved.
//

import WaltzAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        WaltzSDKMgr.sharedManager.initManager(licenseKey: "PUT---YOUR---iOS---LICENSE---HERE", appUid: "PUT---YOUR---VENDOR---UUID---HERE")
        
        return true
    }
}
