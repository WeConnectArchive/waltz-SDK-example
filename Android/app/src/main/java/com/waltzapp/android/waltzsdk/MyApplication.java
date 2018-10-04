package com.waltzapp.android.waltzsdk;

import android.app.Application;

import com.waltzapp.androidsdk.WaltzSDK;

/**
 * The main application.
 */
public class MyApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        // Waltz SDK initialization
        WaltzSDK
                .getInstance()
                .setContext(this)
                .setAppUid(toString(R.string.waltz_app_uid))
                .setLicenseKey(toString(R.string.waltz_app_key))
                .init();
    }

    private String toString(int r) {
        return getResources().getString(r);
    }
}
