package com.waltzapp.android.waltzsdk;

import android.app.Application;

import com.waltzapp.androidsdk.WaltzSDK;

/**
 * Created by kamalazougagh on 2018-09-28.
 */
public class MyApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        // Waltz SDK initialization
        WaltzSDK
                .getInstance()
                .setContext(this)
                .setAppUid("___YOUR_APP_UID___")
                .setLicenseKey("__YOUR_LICENSE_KEY__")
                .init();
    }
}
