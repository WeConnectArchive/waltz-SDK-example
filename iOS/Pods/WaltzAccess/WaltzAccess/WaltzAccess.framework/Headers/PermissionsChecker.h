//
//  PermissionsChecker.h
//  Building Access
//
//  Created by Waltz-Admin on 2017-01-13.
//  Copyright © 2017 Waltz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

static NSString *const APP_CAMERA_PERMISSIONS_REASON;

@protocol PermissionCheckerDelegate <NSObject>
- (void) cameraPermissionsHaveBeenGranted:(BOOL)cameraPermissionsHaveBeenGranted;
@end

@interface PermissionsChecker : NSObject

+ (PermissionsChecker *)sharedInstance;
- (void) checkCameraPermissions;

@property (nonatomic,assign,readonly) CameraPersmissionsAuthStatus appCameraPermissions;
@property (weak,nonatomic) id<PermissionCheckerDelegate> delegate;

@end
