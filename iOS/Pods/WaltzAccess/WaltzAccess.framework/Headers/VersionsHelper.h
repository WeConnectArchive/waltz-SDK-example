//
//  VersionsHelper.h
//  WREFramework
//
//  Created by Guillaume Vachon on 2017-11-28.
//  Copyright © 2017 Waltz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WltzResponseConstants.h"

@class SDK;

#ifndef VersionsHelper_h
#define VersionsHelper_h

@protocol VersionsHelperDelegate<NSObject>
@optional
- (void) didGetVersion:(SDK *_Nullable)versionSDK withErrorCode:(WltzSDKResponseCodes)errorCode;
@end

@interface VersionsHelper : NSObject

@property (weak,nonatomic) _Nullable id <VersionsHelperDelegate> delegate;
- (void) getVersion;

@end

#endif /* VersionsHelper_h */
