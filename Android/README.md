# The Android Waltz SDK

These instruction show how to build the **android** example using the Waltz Android SDK.
Waltz provides to their partners two values that are specific to a Waltz partner and allows use of the SDK.
This set of values is specific to the platform, so using the **iOS** vales for an **android** project will not work.

These values are specific to a 3rd party application and should be kept private:

+ The application UUID (.e.g: **befbae25-f709-488d-b220-c90f09afd01d**)
+ The application license key (e.g.: **befbae25-f709-488d-b220-c90f09afd01d**)
	<!-- Replace the vales of the 2 lines below with the licences provided by Waltz -->
	<string name="waltz_app_uid">___YOUR_APP_UID___</string>
	<string name="waltz_app_key">__YOUR_LICENSE_KEY__</string>

Below are the steps required to get build and run the **android** example with your credentials:

1. Enter your license information

Edit your [./app/src/main/res/values/license.xml](./app/src/main/res/values/license.xml) license file and replace the `___YOUR_APP_UID___` and `__YOUR_LICENSE_KEY__` values with those that where provided by Waltz.
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>

    <!-- Replace the vales of the 2 lines below with the licences provided by Waltz -->
    <string name="waltz_app_uid">___YOUR_APP_UID___</string>
    <string name="waltz_app_key">__YOUR_LICENSE_KEY__</string>

</resources>
```

2. Build the sample application

This can be done with either **Android Studio**, or from the command line using grade:

```bash
✔ ~/Documents/GitHub/waltz-SDK-example/Android [master|✚]
12:34 $ ./gradlew clean build

> Task :app:lint

BUILD SUCCESSFUL in 0m 23s
59 actionable tasks: 58 executed, 1 up-to-date
```

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
			
## Customize the login visual

You can specify the login visual (background image, logo and primary color). Those value are all option, so if you don't specify any it will take the default (Waltz brand). To do so you need to call the following:

                // Waltz SDK initialization
        	WaltzSDK
                	.getInstance()
                	.setContext(this)
                	.setAppUid(getString(R.string.waltz_app_uid))
                	.setLicenseKey(getString(R.string.waltz_app_key))
			
                	.setLoginVisual(R.drawable.login_image, R.drawable.login_logo, Color.RED)
			
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

## User informations

The user have to be logged in to use it.

Get user infos
   
        WaltzSDK.getInstance().getUserInfos();

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
        FEATURE_DISABLE,

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
