package com.waltzapp.android.waltzsdk;

import android.app.Application;
import android.support.annotation.NonNull;
import android.util.Log;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;
import com.waltzapp.androidsdk.WaltzSDK;

/**
 * The main application.
 */
public class MyApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        initWaltzSDK();
    }

    /**
     * Waltz SDK Initialization
     */
    private void initWaltzSDK() {
        // Waltz SDK initialization
        WaltzSDK
                .getInstance()
                .setContext(this)
                .setAppUid(toString(R.string.waltz_app_uid))
                .setLicenseKey(toString(R.string.waltz_app_key))
                .init();

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
    }

    private String toString(int r) {
        return getResources().getString(r);
    }
}
