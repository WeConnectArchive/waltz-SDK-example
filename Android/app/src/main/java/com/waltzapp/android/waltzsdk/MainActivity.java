package com.waltzapp.android.waltzsdk;

import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;

import com.waltzapp.androidsdk.WaltzCode;
import com.waltzapp.androidsdk.WaltzLogInFragment;
import com.waltzapp.androidsdk.WaltzTransactionFragment;
import com.waltzapp.androidsdk.callback.LogInCallback;
import com.waltzapp.androidsdk.callback.TransactionCallback;
import com.waltzapp.androidsdk.pojo.DDInfos;

public class MainActivity extends AppCompatActivity implements MainFragment.Listener {

    private MyDialog mMyDialog;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getSupportFragmentManager()
                    .beginTransaction()
                    .add(R.id.main_content, new MainFragment())
                    .commit();
        }
    }

    @Override
    public void onLogin() {
        WaltzLogInFragment fragment = WaltzLogInFragment.newInstance(new LogInCallback() {
            @Override
            public void onComplete(WaltzCode waltzCode) {
                showDialog(waltzCode, null);
            }
        });

        // Custom visual
        fragment.setVisual(R.drawable.login_image, R.drawable.login_logo, Color.RED);

        startFragment(fragment);
    }

    @Override
    public void onStartTransaction() {
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

        startFragment(fragment);
    }

    private void startFragment(Fragment fragment) {
        getSupportFragmentManager()
                .beginTransaction()
                .replace(R.id.main_content, fragment)
                .addToBackStack(null)
                .commit();
    }


    private void showDialog(WaltzCode waltzCode, DDInfos ddInfos) {
        if (mMyDialog == null) {
            mMyDialog = MyDialog
                    .with(waltzCode)
                    .setListener(new MyDialog.Listener() {
                        @Override
                        public void onDismiss() {
                            getSupportFragmentManager().popBackStack();
                            mMyDialog = null;
                        }
                    })
                    .setDDInfos(ddInfos);
            mMyDialog.show(getSupportFragmentManager(), "dialog");
        }
        else if (ddInfos != null) {
            mMyDialog.refreshDDInfos(ddInfos);
        }
    }
}