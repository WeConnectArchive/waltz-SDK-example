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

1. Build the sample application

This can be done with either **Android Studio**, or from the command line using grade:

```bash
✔ ~/Documents/GitHub/waltz-SDK-example/Android [master|✚]
12:34 $ ./gradlew clean build

> Task :app:lint

BUILD SUCCESSFUL in 0m 23s
59 actionable tasks: 58 executed, 1 up-to-date
```