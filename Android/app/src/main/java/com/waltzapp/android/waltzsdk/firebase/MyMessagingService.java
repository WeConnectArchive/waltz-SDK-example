package com.waltzapp.android.waltzsdk.firebase;

import android.util.Log;

import com.google.firebase.messaging.RemoteMessage;
import com.waltzapp.androidsdk.firebase.WaltzMessagingService;

/**
 * Created by kamalazougagh on 2018-11-28.
 */
public class MyMessagingService extends WaltzMessagingService {

    @Override
    protected void onNewMessageReceived(RemoteMessage remoteMessage) {
        super.onNewMessageReceived(remoteMessage);
        Log.d("Firebase", "onNewMessageReceived \n" + remoteMessage.getData().toString());
    }
}
