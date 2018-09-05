package com.waltzapp.android.waltzsdk;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Toast;

import com.waltzapp.androidsdk.WaltzTransactionFragment;

public class MainActivity extends AppCompatActivity {

    private final int REQUEST_CAMERA = 1;
    private WaltzTransactionFragment mWaltzFragment;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.main_login).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mWaltzFragment = WaltzTransactionFragment.newInstance("YOUR_LICENSE_KEY", getListener());
                startFragment(mWaltzFragment);
            }
        });

        findViewById(R.id.main_clear).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (mWaltzFragment != null) mWaltzFragment.clearWaltzData();
            }
        });

        findViewById(R.id.main_camera_permission).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (ContextCompat.checkSelfPermission(MainActivity.this, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.CAMERA}, REQUEST_CAMERA);
                }
                else {
                    Toast.makeText(MainActivity.this, getString(R.string.camera_permission_granted), Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    private WaltzTransactionFragment.Listener getListener() {
        return new WaltzTransactionFragment.Listener() {
            @Override
            public void onTransactionDone(WaltzTransactionFragment.StatusCode statusCode) {
                Toast.makeText(MainActivity.this, "Status code: " + statusCode, Toast.LENGTH_SHORT).show();
                getSupportFragmentManager().popBackStack();
            }
        };
    }

    private void startFragment(Fragment fragment) {
        getSupportFragmentManager()
                .beginTransaction()
                .add(android.R.id.content, fragment)
                .addToBackStack(null)
                .commit();
    }
}