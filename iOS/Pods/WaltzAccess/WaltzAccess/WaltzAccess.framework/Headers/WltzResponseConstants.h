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
typedef enum {
    
    // SDK validation
    APP_UID_NOT_EXIST,
    LICENSE_KEY_NOT_EXIST,
    LICENSE_KEY_IS_EXPIRED,
    SDK_VERSION_IS_EXPIRED,
    SDK_NOT_INITIALIZED,
    NO_INTERNET_CONNECTION,
    UNKNOWN_PLATFORM,
    INVALID_JWT,
    SHOULD_LOGIN,
    FEATURE_DISABLE,
    
    // Transaction
    ACCESS_GRANTED,
    ACCESS_DENIED,
    CAMERA_PERSMISSION_NOT_GRANTED,
    
    // Authentification
    FORGOT_PASSWORD_REQUEST_SEND,
    LOGIN_CANCELLED,
    LOGIN_FAILED,
    LOGOUT,
    
    // Guests
    INVALID_FIRST_NAME,
    INVALID_LAST_NAME,
    INVALID_EMAIL_FORMAT,
    INVALID_START_DATE,
    INVALID_END_DATE,
    USER_CANNOT_INVITE,
    
    // Geofence
    LOCATION_PERSMISSION_NOT_GRANTED,
    NOTIFICATION_PERSMISSION_NOT_GRANTED,
    
    // Backend response
    SUCCESS,
    FAILURE
} SDKResponseCodes;

#endif /* WltzResponseConstants_h */
