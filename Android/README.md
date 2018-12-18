# The Android Waltz SDK

These instruction show how to build the **android** example using the Waltz Android SDK.
Waltz provides to their partners two values that are specific to a Waltz partner and allows use of the SDK.
This set of values is specific to the platform, so using the **iOS** values for an **android** project will not work.

These values are specific to a 3rd party application and should be kept private:

+ The application UUID (.e.g: **befbae25-f709-488d-b220-c90f09afd01d**)
+ The application license key (e.g.: **befbae25-f709-488d-b220-c90f09afd01d**)
	<!-- Replace the vales of the 2 lines below with the licences provided by Waltz -->
	<string name="waltz_app_uid">___YOUR_APP_UID___</string>
	<string name="waltz_app_key">__YOUR_LICENSE_KEY__</string>

Below are the steps required to get build and run the **android** example with your credentials:

### Enter your license information

Edit your [./app/src/main/res/values/license.xml](./app/src/main/res/values/license.xml) license file and replace the `___YOUR_APP_UID___` and `__YOUR_LICENSE_KEY__` values with those that where provided by Waltz.
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>

    <!-- Replace the vales of the 2 lines below with the licences provided by Waltz -->
    <string name="waltz_app_uid">___YOUR_APP_UID___</string>
    <string name="waltz_app_key">__YOUR_LICENSE_KEY__</string>

</resources>
```

### Build the sample application

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

## Login

### Start login
		  
	  	public void onLogin() {
			WaltzLogInFragment fragment = WaltzLogInFragment.newInstance(new WaltzCallback() {
			    @Override
			    public void onTransactionDone(WaltzCode waltzCode) {
				Toast.makeText(MainActivity.this, "Status code: " + waltzCode, Toast.LENGTH_SHORT).show();
				getSupportFragmentManager().popBackStack();
			    }
			});
			startFragment(fragment);
		    }

### Determine if you should login before starting a transaction
		if (WaltzSDK.getInstance().shouldLogin()) {
			// start login
		}

### Customize the login visual

You can specify the login visual (background image, logo and primary color). Those value are all option, so if you don't specify any it will take the default (Waltz brand). To do so you need to call the following:

                public void onLogin() {
			WaltzLogInFragment fragment = WaltzLogInFragment.newInstance(new WaltzCallback() {
			    @Override
			    public void onTransactionDone(WaltzCode waltzCode) {
				Toast.makeText(MainActivity.this, "Status code: " + waltzCode, Toast.LENGTH_SHORT).show();
				getSupportFragmentManager().popBackStack();
			    }
			});

			// Custom visual
			fragment.setVisual(R.drawable.login_image, R.drawable.login_logo, Color.RED);

			startFragment(fragment);
		    }

## Start a transaction

### On your Activity or fragment

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
### Start the service
			
		WaltzSDK
			.getInstance()
			.setCallback(new WaltzCallback() {
			    @Override
			    public void onTransactionDone(WaltzCode waltzCode) {
				Toast.makeText(getContext(), "Status code: " + waltzCode, Toast.LENGTH_SHORT).show();
			    }
			})
			.startGeofencing();

### Stop the service

		WaltzSDK
			.getInstance()
			.setCallback(new WaltzCallback() {
			    @Override
			    public void onTransactionDone(WaltzCode waltzCode) {
				Toast.makeText(getContext(), "Status code: " + waltzCode, Toast.LENGTH_SHORT).show();
			    }
			})
			.stopGeofencing();

### Customize notification - Call setter when initializing the SDK

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
### Send an invitation

		String firstName = "My first name";
		String lastName = "My last name";
		String email = "myemail@example.com";
		String phoneNumber = "My phone"; // Optional

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

### My Guests (invitations sent)

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

### My Invitations (invitations received)

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

## Destination dispatch

1. In order to receive the destination dispatch informations, you should create a Firebase project
https://firebase.google.com/docs/android/setup

2. Then set up Firebase Cloud Messaging
https://firebase.google.com/docs/cloud-messaging/android/client

3. Send to Waltz your FCM Server Key at sdksupport@waltzapp.com

3. In your Application class, get the Fcm Token and and send it to the WaltzSDK

        FirebaseInstanceId.getInstance().getInstanceId()
                .addOnCompleteListener(new OnCompleteListener<InstanceIdResult>() {
                    @Override
                    public void onComplete(@NonNull Task<InstanceIdResult> task) {
                        if (task.isSuccessful()) {
                            String token = task.getResult().getToken();
                            Log.d("Token", "Firebase Token:\n" + token);
                            WaltzSDK.getInstance().updateFcmToken(token);
                        }
                    }
                });

4. In your MyMessagingService class, send new token received to the WaltzSDK and check if the message received belongs to the WaltzSDK or not.

        public class MyMessagingService extends FirebaseMessagingService {
        
		    @Override
		    public void onNewToken(String token) {
			super.onNewToken(token);
			WaltzSDK.getInstance().updateFcmToken(token);
		    }

		    @Override
		    public void onMessageReceived(RemoteMessage remoteMessage) {
			super.onMessageReceived(remoteMessage);
			if (! WaltzSDK.getInstance().isWaltzRemoteMessage(remoteMessage.getData())) {
			    // Handle your message
			}
		    }
        }

5. Declare the service in the AndroidManifest.xml

		<!--Waltz Messaging service-->
		<service android:name=".firebase.MyMessagingService">
			<intent-filter>
				<action android:name="com.google.firebase.MESSAGING_EVENT" />
			</intent-filter>
		</service>

6. During the transaction, if the destination dispatch informations is known, you will receive a DDInfos object that contains two String values (elevator and floor)

        WaltzTransactionFragment fragment = WaltzTransactionFragment.newInstance(new TransactionCallback() {
            @Override
            public void onTransactionDone(WaltzCode waltzCode) {
                showDialog(waltzCode, null);
            }

            @Override
            public void onTransactionDone(WaltzCode waltzCode, DDInfos ddInfos) {
                showDialog(waltzCode, ddInfos);
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
