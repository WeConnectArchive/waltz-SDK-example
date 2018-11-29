# waltz-SDK-example

git clone https://github.com/WaltzApp/waltz-SDK-example

# iOS

IMPORTANT: Need to be sure not to compile for emulator but for a generic device or a real device

cd iOS

pod install

## SDK initialization

1. In your Podfile make sure to add the following sources:

        source 'https://github.com/WaltzApp/Podspecs.git' # To have access to Waltz Pods/Framework
    
        source 'https://github.com/CocoaPods/Specs.git'   # To continue to have access to regular Public Pods

2. Add the following dependency:

        pod 'WaltzAccess', :inhibit_warnings => true

3. Open the workspace (ThirdParty.xcworkspace)

4. Open the AppDelegate.swift

5. Change the following line with your license and your appUid:

        WaltzSDKMgr.sharedManager.initManager(licenseKey: "PUT---YOUR---iOS---LICENSE---HERE", appUid: "PUT---YOUR---VENDOR---UUID---HERE")
	
	
6. Make sure to set the architecture flag to "NO" (Build Active Architecture Only) <p align="center">
  <img src="./ThirdParty - Architecture setup.png" width="800" title="Architecture setup">
</p>

7. Make sure to select "Generic iOS Device" and not a emulator <p align="center">
  <img src="./Generic Device Setup.png" width="400" title="Architecture setup">
</p>

You can now build and run on a device

## Customize the login visual

You can specify the login visual (background image, logo, background color and primary color). Those value are all option, so if you don't specify any it will take the default (Waltz brand). To do so you need to call the following:

      WaltzSDKMgr.sharedManager.setLoginVisual(backgroundImage: UIImage, logo: UIImage, backgroundColor: UIColor, primaryColor: UIColor)

## Log the user In

Internet connection is required

To request the login flow you need to call the following function:

        WaltzSDKMgr.sharedManager.logIn()
	
The result will be send in the following callback (WltzSDKMgrDelegate):

            func didFinishWaltzLogin(_ errorCode: SDKResponseCodes)

## Start a transaction

The user have to be logged in to use it.
Internet connection is required

You need to request the camera permission

1. You need to call the following function:

        WaltzSDKMgr.sharedManager.beginTransaction()

Then the first time you will have to log with valid credential and you will then be redirect to the QR that will enable you to open a door (that you have access) after that the user won't have to log again if he use the application regularly.

2. Transaction result: you have 1 callback (WltzSDKMgrDelegate) that you can implement:

        func didFinishWaltzTransactionWithErrorCode(_ errorCode: SDKResponseCodes)
    
## Geofencing feature

The user have to be logged in to use it.
Internet connection is required for the first call after that it is no longer need but if it is not provided the geofence won't be updated.

You need to request the location and notication permission

1. Start the service

        WaltzSDKMgr.sharedManager.startGeofenceService()
    
2. Stop the service

        WaltzSDKMgr.sharedManager.stopGeofenceService()

3. Gefence result: you have 1 callback (WltzSDKMgrDelegate) that you can implement:

        func didFinishWaltzGeofenceSetupWithErrorCode(_ errorCode: SDKResponseCodes)

## Guest feature

The user have to be logged in to use it.
Internet connection is required for all calls

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

4. Results are sent in those 3 functions:

        func didGetWaltzMyGuestsWithErrorCode(_ errorCode: SDKResponseCodes, guests: [InvitationResponse]?)

        func didGetWaltzMyInvitationsWithErrorCode(_ errorCode: SDKResponseCodes, invitations: [InvitationResponse]?)

        func didSendWaltzInvitationWithErrorCode(_ errorCode: SDKResponseCodes)
    
2 first two have a list of invitations that were made by the user and the last one only the status

## User informations

The user have to be logged in to use it.

1. Get user infos
   
        WaltzSDKMgr.sharedManager.getUserInfos()

2. Results are sent in this function:

        func didGetWaltzUserInfoWithErrorCode(_ errorCode: SDKResponseCodes, userInfo: WaltzUserInfos?)

If the status is SUCCESS you will have the user informations inside the WaltzUserInfos that look like that:

	public class WaltzUserInfos {
	    public let email: String
	    public let name: String
	    public let id: UUID
    	}

## Waltz error code

    typedef enum {
    
        // SDK validation
        APP_UID_NOT_EXIST,
        LICENSE_KEY_NOT_EXIST,
        LICENSE_KEY_IS_EXPIRED,
        SDK_VERSION_IS_EXPIRED,
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

If you want to have a newer version of the SDK run the following command where the "Podfile" is located

	   pod update


SDK supports TabBarViewController and NavigationController. The SDK UI will be embedded automatically in its parent. To see both working just change the "Entry Point" in the example storyboard.
