# waltz-SDK-example

git clone https://github.com/WaltzApp/waltz-SDK-example

# iOS
cd iOS

pod install


Open the workspace (ThirdParty.xcworkspace)

Open the ViewController.swift

Change the following line with your license:

WaltzTransactionMgr.sharedManager.beginTransaction(withLicenseKey: "PUT---YOUR---iOS---LICENSE---HERE")


You can build and run on a device

You Need to click on "Start transaction"

Then the first time you will have to log with valid credential and you will then be redirect to the QR that will enable you to open a door (that you have access)


You have 1 callback (WltzTransactionMgrDelegate) that you can implement:

    func didFinishWaltzTransactionWithErrorCode(_ errorCode: WltzTransactionResponseCodes)


The code you can receive are the following:

typedef enum{

    WltzMissingCameraPermissions = 11,

    WltzNoInternetAccess,

    WltzFailedToSignIn,

    WltzFailedToRefreshJWT,

    WltzFailedToResetEmail,

    WltzFailedToRefreshKeys,

    WltzCouldNotFinishTransaction,

    WltzAcessGranted,

    WltzUserCancelledTransaction,

    WltzTrialPeriodExpired,

    WltzIncorredLicenseKey,

    WltzSDKVersionInvalid,

    WltzVersionFormatInvalid,

    WltzVersionError,

    WltzMutualLogout,

    WltzNoError
    
}WltzTransactionResponseCodes;

# Android
cd Android

The Waltz Android SDK is functional and ready to use if you have a valid Waltz account with access to doors.

How to set up an Android project to use our Waltz Android SDK:

1. Get a license key.

2. Top-level build.gradle:

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
     			implementation 'com.android.support:appcompat-v7:28.0.0-rc02'
     			...

     			// Waltz
     			implementation 'com.waltzapp.transaction:waltz-sdk:1.0.13'
			}
		}

4. Sync Project with Gradle Files

5. On your Activity or fragment

 		// Note : Request camera permission before calling startTransaction().
 		private void startTransaction() {
     		mTransactionFragment = TransactionFragment.newInstance("YOUR_LICENSE_KEY", getListener());
     		getSupportFragmentManager()
             	.beginTransaction()
             	.replace(android.R.id.content, fragment)
             	.addToBackStack(null)
             	.commit();
 		}

 		private TransactionFragment.Listener getListener() {
     		return new TransactionFragment.Listener() {
         		@Override
         		public void onTransactionDone(TransactionFragment.StatusCode code) {
             		Toast.makeText(MainActivity.this, "Status code: " + code, Toast.LENGTH_SHORT).show();
             		getSupportFragmentManager().popBackStack();
         		}
     		};
 		}


		//Possible code
		public enum StatusCode {
     		ACCESS_GRANTED,
     		ACCESS_DENIED,
     		CAMERA_PERMISSION_NOT_GRANTED,
     		INVALID_LICENSE_KEY,          
     		INVALID_JWT,
     		INVALID_SDK_VERSION,
     		SDK_IS_EXPIRED,               // The SDK version is out of date
     		NO_INTERNET_CONNECTION,       
     		BACKEND_OFFLINE,
     		ERROR_VERSION,
     		LOGIN_FAILED,                 // Invalid username or password
     		LOGIN_CANCELLED,              // Login cancelled
     		FORGOT_PASSWORD_REQUEST_SENT, // The user sent a request to reset his password
     		LOGOUT                        // The user logged in an other app
 		}
