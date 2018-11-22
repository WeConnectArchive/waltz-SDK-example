package com.waltzapp.android.waltzsdk;

import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.widget.Toast;

import com.waltzapp.androidsdk.WaltzCallback;
import com.waltzapp.androidsdk.WaltzCode;
import com.waltzapp.androidsdk.WaltzLogInFragment;
import com.waltzapp.androidsdk.WaltzTransactionFragment;

public class MainActivity extends AppCompatActivity implements MainFragment.Listener {


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

    @Override
    public void onStartTransaction() {
        WaltzTransactionFragment fragment = WaltzTransactionFragment.newInstance(new WaltzCallback() {
            @Override
            public void onTransactionDone(WaltzCode waltzCode) {
                Toast.makeText(MainActivity.this, "Status code: " + waltzCode, Toast.LENGTH_SHORT).show();
                getSupportFragmentManager().popBackStack();
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
}