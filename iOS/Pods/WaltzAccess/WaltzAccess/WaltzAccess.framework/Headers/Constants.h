//
//  Constants.h
//  Waltz SDK
//
//  Created by Waltz-Admin on 2017-08-22.
//  Copyright © 2017 Waltz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WltzResponseConstants.h"

extern NSString *const WREFrameworkVersionNumber;

extern NSString *const StoryboardName;
extern NSString *const LoginStoryBoardID;

/*
 The keys used to store and retrive values from NSUserDefaults
 */
extern NSString *const kLicense;
extern NSString *const kVendorUUID;

/*
    Regex for password and email
 */
extern NSString *const EMAIL_REGEX;
extern NSString *const PASSWORD_REGEX;
extern NSString *const NEW_PASSWORD_REGEX;
extern NSString *const PHONE_REGEX;

typedef enum {
    CameraPermissionsDenied,
    CameraPermissionsNotDeterminedOrRestricted,
    CameraPermissionsGranted,
    CameraPersmissionsDefault
} CameraPersmissionsAuthStatus;
