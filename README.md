# waltz-SDK-example

git clone https://github.com/WaltzApp/waltz-SDK-example

# iOS
cd iOS
pod install

Open the workspace (ThirdParty.xcworkspace)
Open the ViewController.swift
Change the following line with your license:
WaltzTransactionMgr.sharedManager.beginTransaction(withLicenseKey: "PUT---YOUR---iOS---LICENSE---HERE")

You can build and run on a device
You Need to click on "Start transaction"
Then the first time you will have to log with valid credential and you will then be redirect to the QR that will enable you to open a door (that you have access)

You have 1 callback (WltzTransactionMgrDelegate) that you can implement:
    func didFinishWaltzTransactionWithErrorCode(_ errorCode: WltzTransactionResponseCodes)

The code you can receive are the following:
typedef enum{
    WltzMissingCameraPermissions = 11,
    WltzNoInternetAccess,
    WltzFailedToSignIn,
    WltzFailedToRefreshJWT,
    WltzFailedToResetEmail,
    WltzFailedToRefreshKeys,
    WltzCouldNotFinishTransaction,
    WltzAcessGranted,
    WltzUserCancelledTransaction,
    WltzTrialPeriodExpired,
    WltzIncorredLicenseKey,
    WltzSDKVersionInvalid,
    WltzVersionFormatInvalid,
    WltzVersionError,
    WltzMutualLogout,
    WltzNoError
}WltzTransactionResponseCodes;
