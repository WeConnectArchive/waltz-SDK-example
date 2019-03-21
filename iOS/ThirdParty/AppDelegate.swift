//
//  AppDelegate.swift
//  ThirdParty
//
//  Created by Guillaume Vachon on 2018-08-14.
//  Copyright © 2018 Waltz. All rights reserved.
//

import Firebase
import FirebaseMessaging
import UserNotifications
import WaltzAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let _ = WaltzSDKMgr.sharedManager.initManager(licenseKey: "PUT---YOUR---iOS---LICENSE---HERE", appUid: "PUT---YOUR---VENDOR---UUID---HERE").setLoginVisual(backgroundImage: UIImage(named: "background"), logo: UIImage(named: "logo"), backgroundColor: UIColor.black, primaryColor: UIColor(red: 46/255, green: 104/255, blue: 116/255, alpha: 1.0)) // PROD
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    // MARK: REMOTE NOTIFICATION METHODS
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if #available(iOS 10.0, *) {
            if !WaltzSDKMgr.sharedManager.onReceiveNotification(userInfo) {
                // This is a notification that belongs to your applicaiton
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: FCM METHODS
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        WaltzSDKMgr.sharedManager.updateFcmToken(fcmToken)
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
}

