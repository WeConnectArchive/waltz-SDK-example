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

extern NSString *const QRPageStoryBoardID;
extern NSString *const CoverScreenViewControllerID;
extern NSString *const StoryboardName;
extern NSString *const LoginStoryBoardID;

/*
    Regex for password and email
 */
extern NSString *const PASSWORD_REGEX;
extern NSString *const EMAIL_REGEX;

typedef enum {
    CameraPermissionsDenied,
    CameraPermissionsNotDeterminedOrRestricted,
    CameraPermissionsGranted,
    CameraPersmissionsDefault
} CameraPersmissionsAuthStatus;

@protocol WltzTransactionProgressDelegate <NSObject>
- (void) didFinishTransactionWithOptionalError:(WltzTransactionResponseCodes)errorCode;
@end
