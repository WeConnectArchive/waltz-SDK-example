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


## Start a transaction

Internet connection is required

You need to request the camera permission

1. You need to call the fallowing function:

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

# Android
cd Android

The Waltz Android SDK is functional and ready to use if you have a valid Waltz account with access to doors.

## How to set up an Android project to use our Waltz Android SDK:

1. Get your AppUid and your LicenseKey.

2. gradle.properties:

		### Waltz Artifcatory Credentials ###
		waltz_url=https://waltzapp.jfrog.io/waltzapp/waltz-release-libs
		waltz_username=waltz-android-partner
		waltz_password=APgNfotiYNKjKxnsJLGic6xAfw

3. Top-level build.gradle:

		allprojects {
			repositories {
				...
				maven {
            		    url waltz_url
             		    credentials {
                 		    username waltz_username
                 		    password waltz_password
             		    }
         		}
     		}
 		}

3. App-level build.gradle:

		android {
     		defaultConfig {
         		minSdkVersion 21 //minSdkVersion cannot be smaller than 21
         		...
     		}
 			dependencies {
   
     			// Android
     			implementation 'com.android.support:appcompat-v7:28.0.0'
     			...

     			// Waltz
     			implementation 'com.waltzapp.transaction:waltz-sdk:1.1.0-rc01'
			}
		}

4. Sync Project with Gradle Files

## SDK initialization

On your Application class

        	// Waltz SDK initialization
        	WaltzSDK
                	.getInstance()
                	.setContext(this)
                	.setAppUid("___YOUR_APP_UID___")
                	.setLicenseKey("__YOUR_LICENSE_KEY__")
                	.init();

## Start a transaction

1. On your Activity or fragment

		public void onStartTransaction() {
			WaltzTransactionFragment fragment = WaltzTransactionFragment.newInstance(new WaltzCallback() {
				@Override
				public void onTransactionDone(WaltzCode waltzCode) {
					if (waltzCode == WaltzCode.ACCESS_GRANTED) {
						// Handle ACCESS_GRANTED waltz code
					}
					else {
						// Handle ACCESS_DENIED waltz code
					}
				}
			});
			startFragment(fragment);
		}

		private void startFragment(Fragment fragment) {
			getSupportFragmentManager()
				.beginTransaction()
				.replace(R.id.main_content, fragment)
				.addToBackStack(null)
				.commit();
		}


## Geofencing feature
1. Start the service
			
		WaltzSDK
			.getInstance()
			.setCallback(new WaltzCallback() {
			    @Override
			    public void onTransactionDone(WaltzCode waltzCode) {
				Toast.makeText(getContext(), "Status code: " + waltzCode, Toast.LENGTH_SHORT).show();
			    }
			})
			.startGeofencing();

2. Stop the service

		WaltzSDK
			.getInstance()
			.setCallback(new WaltzCallback() {
			    @Override
			    public void onTransactionDone(WaltzCode waltzCode) {
				Toast.makeText(getContext(), "Status code: " + waltzCode, Toast.LENGTH_SHORT).show();
			    }
			})
			.stopGeofencing();

3. Customize notification - Call setter when initializing the SDK

        // Waltz SDK initialization
        WaltzSDK
                .getInstance()
                .setContext(this)
                .setAppUid("___YOUR_APP_UID___")
                .setLicenseKey("__YOUR_LICENSE_KEY__")
		
                .setNotificationTextColor("__YOUR_COLOR__")
                .setNotificationText("__TEXT_UNDER_THE_TITLE__")
                .setNotificationIcon("__YOUR_ICON__")
                .setNotificationLargeIcon("__YOUR_LARGE_ICON__")
		
                .init();


## Guest feature
1. Send an invitation

		String firstName = "Android SDK first name";
		String lastName = "Android SDK last name";
		String email = "androidsdk@example.com";
		String phoneNumber = "5145457878"; // Optional

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		Date startDate = calendar.getTime();

		calendar.add(Calendar.MINUTE, 30);
		Date endDate = calendar.getTime();

		WaltzSDK
			.getInstance()
			.sendInvitation(firstName, lastName, email, phoneNumber, startDate, endDate, new SendInvitationCallback() {
			    @Override
			    public void onInvitationSent(WaltzCode code) {
				Log.d("LIB", "onInvitationSent() code : " + code);
				Toast.makeText(getContext(), "Code: " + code, Toast.LENGTH_SHORT).show();
			    }
			});

2. My Guests (invitations sent)

		WaltzSDK
			.getInstance()
			.fetchMyGuests(new InvitationsCallback() {
			@Override
			public void onInvitationsReceived(WaltzCode code, List<Invitation> invitationList) {
				if (code == WaltzCode.SUCCESS) {
					// Display result
				}
				else {
					// Handle error
				}
			}
		});

3. My Invitations (invitations received)

		WaltzSDK
			.getInstance()
			.fetchMyInvitations(new InvitationsCallback() {
			@Override
			public void onInvitationsReceived(WaltzCode code, List<Invitation> invitationList) {
				if (code == WaltzCode.SUCCESS) {
				    // Display result
				}
				else {
				    // Handle error
				}
			}
		});

## Waltz error code
	public enum WaltzCode {

	    // SDK Validation
	    APP_UID_NOT_EXIST,
	    LICENSE_KEY_NOT_EXIST,
	    LICENSE_KEY_IS_EXPIRED,
	    SDK_VERSION_IS_EXPIRED,
	    SDK_NOT_INITIALIZED,
	    NO_INTERNET_CONNECTION,
	    UNKNOWN_PLATFORM,
	    INVALID_JWT,
	    SHOULD_LOGIN,

	    // Transaction
	    ACCESS_GRANTED,
	    ACCESS_DENIED,
	    CAMERA_PERMISSION_NOT_GRANTED,

	    // Authentication
	    FORGOT_PASSWORD_REQUEST_SENT,
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
	    LOCATION_PERMISSION_NOT_GRANTED,

	    //Backend response
	    SUCCESS,
	    FAILURE,
	}
