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

        let _ = WaltzSDKMgr.sharedManager.initManager(licenseKey: "PUT---YOUR---iOS---LICENSE---HERE", appUid: "PUT---YOUR---VENDOR---UUID---HERE").setLoginVisual(backgroundImage: UIImage(named: "background"), logo: UIImage(named: "logo"), backgroundColor: UIColor.black, primaryColor: UIColor(red: 46/255, green: 104/255, blue: 116/255, alpha: 1.0))

        return true
    }
}
