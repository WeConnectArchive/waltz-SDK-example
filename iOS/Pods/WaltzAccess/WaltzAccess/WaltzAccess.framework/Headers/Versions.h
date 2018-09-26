//
//  Versions.h
//  WREFramework
//
//  Created by Guillaume Vachon on 2017-11-28.
//  Copyright © 2017 Waltz. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Versions_h
#define Versions_h

@interface Expiration : NSObject

- (instancetype) initExpirationWithDict:(NSDictionary *)dict;
@property (strong,nonatomic) NSString *version, *date;

@end

@interface SDK : NSObject

- (instancetype) initSDKWithDict:(NSDictionary *)dict;
@property (strong,nonatomic) NSString *minVersion;
@property (strong,nonatomic) NSArray *expirations;

@end

@interface IOS : NSObject

- (instancetype) initIOSWithDict:(NSDictionary *)dict;
@property (strong,nonatomic) SDK *sdk;

@end

@interface RealEstate : NSObject

- (instancetype) initRealEstateWithDict:(NSDictionary *)dict;
@property (strong,nonatomic) IOS *ios;

@end

@interface Applications : NSObject

- (instancetype) initApplicationsWithDict:(NSDictionary *)dict;
@property (strong,nonatomic) RealEstate *re;

@end

@interface Versions : NSObject

- (instancetype) initVersionsWithDict:(NSDictionary *)dict;
@property (strong,nonatomic) Applications *applications;

@end

#endif /* Versions_h */
