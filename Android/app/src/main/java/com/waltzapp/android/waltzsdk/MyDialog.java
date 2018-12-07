package com.waltzapp.android.waltzsdk;

import android.app.Dialog;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.waltzapp.androidsdk.WaltzCode;
import com.waltzapp.androidsdk.pojo.DDInfos;

import static com.waltzapp.androidsdk.WaltzCode.ACCESS_GRANTED;

/**
 * Created by kamalazougagh on 2018-12-06.
 */
public class MyDialog extends DialogFragment {

    private WaltzCode mCode;
    private DDInfos mData;

    private TextView mTitle, mDDInfos;
    private Button mDismiss;

    private Listener mListener;

    public static MyDialog with(WaltzCode code) {
        MyDialog dialog = new MyDialog();
        dialog.mCode = code;
        return dialog;
    }

    public MyDialog setListener (Listener l) {
        this.mListener = l;
        return this;
    }

    public MyDialog setDDInfos(DDInfos data) {
        this.mData = data;
        return this;
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.my_dialog, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mTitle = view.findViewById(R.id.dialog_title);
        mDDInfos = view.findViewById(R.id.dialog_dd_infos);
        mDismiss = view.findViewById(R.id.dialog_dismiss);

        mDismiss.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dismiss();
                if (mListener != null) mListener.onDismiss();
            }
        });

        mTitle.setText(mCode.toString());

        if (ACCESS_GRANTED == mCode && mData != null) {
            String s = "Elevator: " + mData.elevator + "\nfloor: " + mData.floor;
            mDDInfos.setText(s);
            mDDInfos.setVisibility(View.VISIBLE);
        }
    }

    @Override
    public void onStart() {
        super.onStart();
        Dialog dialog = getDialog();
        dialog.getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        setCancelable(false);
    }

    public void refreshDDInfos(DDInfos data) {
        if (ACCESS_GRANTED == mCode) {
            String s = "Elevator: " + data.elevator + "\nfloor: " + data.floor;
            mDDInfos.setText(s);
            mDDInfos.setVisibility(View.VISIBLE);
        }
    }


    public interface Listener {
        void onDismiss();
    }
}
