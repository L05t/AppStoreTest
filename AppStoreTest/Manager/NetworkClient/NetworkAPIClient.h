//
//  NetworkAPIClient.h
//  AppStoreTest
//
//  Created by 武家成 on 2019/4/22.
//  Copyright © 2019 武家成. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, NetworkStatus) {
    NetworkStatusUnknow = -1,
    NetworkStatusNotReachable,
    NetworkStatusReachableViaWWAN,
    NetworkStatusReachableWifi
};

typedef void(^NetworkStatusBlock)(NetworkStatus status);



@interface NetworkAPIClient : AFHTTPSessionManager

+ (void)sendPostRequestForPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id successData))successBase failure:(void (^)(NSError *error))failureBase;

+ (void)sendGetRequestForPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id successData))successBase failure:(void (^)(NSError *error))failureBase;

+ (void)uploadFileRequestForPath:(NSString *)path parameters:(NSDictionary *)parameters formFileData:(NSData *)formFileData formNameKey:(NSString *)nameKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(id successData))successBase  failure:(void (^)(NSError *error))failureBase;

+ (void)networkStatusWithBlock:(NetworkStatusBlock)networkStatus;

@end

NS_ASSUME_NONNULL_END
