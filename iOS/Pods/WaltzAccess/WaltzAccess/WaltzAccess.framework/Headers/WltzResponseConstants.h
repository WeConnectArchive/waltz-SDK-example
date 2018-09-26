//
//  WltzResponseConstants.h
//  WREFramework
//
//  Created by Waltz-Admin on 2017-09-29.
//  Copyright © 2017 Waltz. All rights reserved.
//

#ifndef WltzResponseConstants_h
#define WltzResponseConstants_h

/*
    The list of response codes that can be returned when performing a 
    Waltz transaction.
 */
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

#endif /* WltzResponseConstants_h */
