# iOS

IMPORTANT:   Ensure that when compiling, you select 'Generic Device' or 'Real Device', and not 'Emulator'. 

cd iOS

Pod install

## SDK initialization

1. In your Podfile, add the following sources:

        source 'https://github.com/WaltzApp/Podspecs.git' # To have access to Waltz Pods/Framework
    
        source 'https://github.com/CocoaPods/Specs.git'   # To have access to regular Public Pods

2. Add the following dependency:

        pod 'WaltzAccess', :inhibit_warnings => true

3. Open Workspace (ThirdParty.xcworkspace)

4. Open AppDelegate.swift

5. Replace the following line with your license & your appUid:

        WaltzSDKMgr.sharedManager.initManager(licenseKey: "PUT---YOUR---iOS---LICENSE---HERE", appUid: "PUT---YOUR---VENDOR---UUID---HERE")
    
    
6. Set the architecture flag to "NO" (Build Active Architecture Only) <p align="center">
  <img src="./ThirdParty - Architecture setup.png" width="800" title="Architecture setup">
</p>

7. Select "Generic iOS Device" (not "emulator") <p align="center">
  <img src="./Generic Device Setup.png" width="400" title="Architecture setup">
</p>

You can now build & run on a device

## Customizing the login Visual element

You can specify the login Visual element (background image, logo, background color & primary color). These values are optional. If none are specified, the default "Waltz" brand will be applied. To specify a login Visual, call the following:

      WaltzSDKMgr.sharedManager.setLoginVisual(backgroundImage: UIImage, logo: UIImage, backgroundColor: UIColor, primaryColor: UIColor)

## Logging the user In

An Internet connection is required

To request the Login flow, call the following function:

        WaltzSDKMgr.sharedManager.logIn()
    
The result will be sent into the following callback (WltzSDKMgrDelegate):

            func didFinishWaltzLogin(_ errorCode: SDKResponseCodes)
            
## Logout the user

In order to leave the SDK in the same state, make sure to call the following function when the user is logged out of your application:

        WaltzSDKMgr.sharedManager.logOut()

## Starting a transaction

The user has to be logged in to use the Login flow.
An Internet connection is required

Requesting camera permissions

1. Call the following function:

        WaltzSDKMgr.sharedManager.beginTransaction()

When you log in for the first time, you'll need valid credentials. Then the QR page appears, which enables access (if you have access). The user won't have to log again if he uses the application regularly. The navigation is taken care of by the SDK (whether it is inside a NavigationController, TabViewController or not). To force the navigation inside a custom view, call the same function but with the following parameters:

        WaltzSDKMgr.sharedManager.beginTransaction(parentView: UIView, parentVC: UIViewController)
    
This will register our SDK controller within the one specified and add our views within the parentView. 

2. Transaction result: you have 1 callback (WltzSDKMgrDelegate) that you can implement:

        func didFinishWaltzTransactionWithErrorCode(_ errorCode: SDKResponseCodes)
    
## Geofencing feature

The user has to be logged in to use it.
An Internet connection is required for the first call, then it is no longer needed but if it is not provided, the geofence doesn't be updated.

You need to request the location and notication permissions

1. Start the service

        WaltzSDKMgr.sharedManager.startGeofenceService()
    
2. Stop the service

        WaltzSDKMgr.sharedManager.stopGeofenceService()

3. Gefence result: you have 1 callback (WltzSDKMgrDelegate) that you can implement:

        func didFinishWaltzGeofenceSetupWithErrorCode(_ errorCode: SDKResponseCodes)

## Guest feature

The user has to be logged in to use it.
An Internet connection is required for all calls

1. Send an invitation

        let firstName = "iOS SDK first name"
        let lastName = "iOS SDK last name"
        let email = "iossdk@example.com"
        let phoneNumber = "5145457878"
        
        let startDate = Date()
        let endDate = Date(timeIntervalSinceNow: 30*60)
        WaltzSDKMgr.sharedManager.sendInvitation(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, startDate: startDate, endDate: endDate)

2. My Guests (invitations sent)

        WaltzSDKMgr.sharedManager.getMyGuests()

3. My Invitations (invitations received)

        WaltzSDKMgr.sharedManager.getMyInvitations()
 
4. Revoke Invitation (only the one that I have sent and that is still active)

        WaltzSDKMgr.sharedManager.revokeInvitation(invitationUUID: UUID)

5. Results are sent in those 3 functions:

        @available(*, deprecated, message: "No longer available, should use didGetWaltzMyGuestsWithUUIDWithErrorCode(_ errorCode: SDKResponseCodes, guests: [(InvitationResponse, UUID)]?) instead!", renamed: "didGetWaltzMyGuestsWithErrorCode()")
        func didGetWaltzMyGuestsWithErrorCode(_ errorCode: SDKResponseCodes, guests: [InvitationResponse]?)
        func didGetWaltzMyGuestsWithUUIDWithErrorCode(_ errorCode: SDKResponseCodes, guests: [(InvitationResponse, UUID)]?)
        
        @available(*, deprecated, message: "No longer available, should use didGetWaltzMyInvitationsWithUUIDWithErrorCode(_ errorCode: SDKResponseCodes, invitations: [(InvitationResponse, UUID)]?) instead!", renamed: "didGetWaltzMyInvitationsWithErrorCode()")
        func didGetWaltzMyInvitationsWithErrorCode(_ errorCode: SDKResponseCodes, invitations: [InvitationResponse]?)
        func didGetWaltzMyInvitationsWithUUIDWithErrorCode(_ errorCode: SDKResponseCodes, invitations: [(InvitationResponse, UUID)]?)
    
        func didRevokeWaltzInvitationWithErrorCode(_ errorCode: SDKResponseCodes)
        
        func didSendWaltzInvitationWithErrorCode(_ errorCode: SDKResponseCodes)
    
2 The first two have a list of invitations made by the user and the last one contain the statuses of these invitations

## User informations

The user has to be logged in to use it.

1. Get user infos
   
        @available(*, deprecated, message: "No longer available, should use getJWT instead!", renamed: "getJWT")
        WaltzSDKMgr.sharedManager.getUserInfos()
        WaltzSDKMgr.sharedManager.getJWT()

2. Results are sent in this function:

        @available(*, deprecated, message: "No longer available, should use didGetWaltzJWTWithErrorCode instead!", renamed: "didGetWaltzJWTWithErrorCode")
        func didGetWaltzUserInfoWithErrorCode(_ errorCode: SDKResponseCodes, userInfo: WaltzUserInfos?)
        func didGetWaltzJWTWithErrorCode(_ errorCode: SDKResponseCodes, jwt: JWT?)

If the status is SUCCESS, the user informations inside the JWT will look like this:

    @available(*, deprecated, message: "No longer available, should use JWT instead!", renamed: "JWT")
    public class WaltzUserInfos {
        public let email: String
        public let name: String
        public let id: UUID
        }
    
    jwt.body["firstName"]
    jwt.body["lastName"]
    jwt.body["userEmail"]
    jwt.body["uid"]
    
## Destination dispatch
In order to receive the destination dispatch information, you must create a Firebase project https://firebase.google.com/docs/ios/setup

Then set up Firebase Cloud Messaging https://firebase.google.com/docs/cloud-messaging/ios/client

Send your FCM Server Key to Waltz at sdksupport@waltzapp.com

1. In your AppDelegate class, inherit from MessagingDelegate and UNUserNotificationCenterDelegate

        import Firebase
        import FirebaseMessaging
        import UserNotifications

        class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate
     
2. In the didFinishLaunchingWithOptions configure Firebase, register delegate

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            Messaging.messaging().delegate = self
        }
    
3. Make sure to request for notification permissions

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
    
4. Send any new FCM token to the SDK by calling this delegate function in the AppDelegate

        // MARK: FCM METHODS
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
            WaltzSDKMgr.sharedManager.updateFcmToken(fcmToken)
            Messaging.messaging().shouldEstablishDirectChannel = true
        }
    
5. Send the notification data (userInfo) to the SDK for it to validate whether it belongs to Waltz or not

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
The onReceiveNotification function returns true if it was handled by the SDK and false if it is for you to handle

5. SDK Callback for FCM update and for DDInfos. You should receive those callback from WltzSDKMgrDelegate if you registered your FCM and if there is any DDInfos (Destination Dispatch informations) available for you to use

        func didUpdateWaltzFCMTokenWithErrorCode(_ errorCode: SDKResponseCodes) {
        print("The Update FCM token quit with error code \(errorCode)")
        }

        func didGetWaltzDDInfos(_ ddInfos: DDInfos) {
        print("We have received the DD infos elevator: \(ddInfos.elevator) floor: \(ddInfos.floor)")
        }
 
## Waltz error code

    typedef enum {
    
        // SDK validation
        APP_UID_NOT_EXIST,
        LICENSE_KEY_NOT_EXIST,
        LICENSE_KEY_IS_EXPIRED,
        SDK_VERSION_IS_EXPIRED,
        SDK_NOT_INITIALIZED,
        NO_INTERNET_CONNECTION,
        UNKNOWN_PLATFORM,
        INVALID_JWT,
        SHOULD_LOGIN,
        FEATURE_DISABLE,
    
        // Transaction
        ACCESS_GRANTED,
        ACCESS_DENIED,
        CAMERA_PERSMISSION_NOT_GRANTED,
    
        // Authentification
        FORGOT_PASSWORD_REQUEST_SEND,
        LOGIN_CANCELLED,
        LOGIN_FAILED,
        LOGOUT,
    
        // Guests
        INVALID_FIRST_NAME,
        INVALID_LAST_NAME,
        INVALID_EMAIL_FORMAT,
        INVALID_START_DATE,
        INVALID_END_DATE,
        USER_CANNOT_INVITE,
    
        // Geofence
        LOCATION_PERSMISSION_NOT_GRANTED,
        NOTIFICATION_PERSMISSION_NOT_GRANTED,
    
        // Backend response
        SUCCESS,
        FAILURE
    } SDKResponseCodes;
    
## Additionnal notes

Installing cocoap install:
https://guides.cocoapods.org/using/getting-started.html

If you want a newer version of the SDK, run the following command where the "Podfile" is located

       pod update


SDK supports TabBarViewController and NavigationController. The SDK UI will be embedded automatically in its parent. To see both working, just change the "Entry Point" in the example storyboard.
