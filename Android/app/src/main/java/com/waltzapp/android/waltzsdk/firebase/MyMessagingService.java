package com.waltzapp.android.waltzsdk.firebase;


import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import com.waltzapp.androidsdk.WaltzSDK;

/**
 * Created by kamalazougagh on 2018-11-28.
 */
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
