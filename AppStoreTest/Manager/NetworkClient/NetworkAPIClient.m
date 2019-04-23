//
//  NetworkAPIClient.m
//  AppStoreTest
//
//  Created by 武家成 on 2019/4/22.
//  Copyright © 2019 武家成. All rights reserved.
//

#import "NetworkAPIClient.h"

NS_ENUM(NSInteger) {
    WWServerErrorCodeUnknown = 0,       //Server未知错误
    };



@implementation NetworkAPIClient

static NetworkAPIClient * _sharedClient = nil;

SINGLETON_FOR_CLASS(NetworkAPIClient);


/**
 Request Header
 */
+ (void)setRequestHeader{
    AFHTTPRequestSerializer *serializer = _sharedClient.requestSerializer;
    serializer.timeoutInterval = 30;
    
    

}



/**
 Post Request

 @param path Url
 @param parameters param
 @param successBase successBlock
 @param failureBase failBlock
 */
+(void)sendPostRequestForPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id _Nonnull))successBase failure:(void (^)(NSError * _Nonnull))failureBase{
    
}


/**
 Get Request

 @param path Url
 @param parameters param
 @param successBase successBlock
 @param failureBase failBlock
 */
+ (void)sendGetRequestForPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id _Nonnull))successBase failure:(void (^)(NSError * _Nonnull))failureBase{
    
}



/**
 Upload File

 @param path Url
 @param parameters param
 @param formFileData data
 @param nameKey name key
 @param fileName file name
 @param mimeType mime type
 @param successBase successBlock
 @param failureBase failBlock
 */
+ (void)uploadFileRequestForPath:(NSString *)path parameters:(NSDictionary *)parameters formFileData:(NSData *)formFileData formNameKey:(NSString *)nameKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(id _Nonnull))successBase failure:(void (^)(NSError * _Nonnull))failureBase{
    
}



+ (void)requestForPath:(NSString *)path parameters:(NSDictionary *)parameters formFileData:(NSData *)formFileData formNameKey:(NSString *)nameKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(id successData))successBase progress:(void(^)(NSProgress * _Nonnull uploadProgress))progressBase failure:(void (^)(NSError *error))failureBase {
    
    if (!KISNullString(path)) {
        NSError *error = [self errorForAPPWithCode:NSURLErrorBadURL];
        
        if (failureBase) {
            failureBase(error);
        }
        return;
    }
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = [self errorForAPPWithCode:NSURLErrorNotConnectedToInternet];
        
        if (failureBase) {
            failureBase(error);
        }
        return;
    }
    NSDictionary *dict = [self composedParameters:parameters];
    [self setRequestHeader];
    
    [_sharedClient POST:path parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (formFileData != nil) {
            [formData appendPartWithFileData:formFileData name:nameKey fileName:fileName mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBase) {
            progressBase(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *msg = responseObject[@"msg"];
//        NSString *jsonString = [self dictionaryToJson:responseObject];
        
        NSNumber *code = responseObject[@"code"];
        if (code && [code integerValue] == 200) {
            id data = responseObject[@"data"];
            if (successBase) {
                successBase(data);
            }
        } else {
            NSError *error = [self errorForServerWithMsg:msg code:code];
            if (failureBase) {
                failureBase(error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        error = [NetworkAPIClient dripCarErrorForAFNError:error];
        if (failureBase) {
            failureBase(error);
        }
    }];
}


+ (NSError *)errorForAPPWithCode:(NSInteger)code {
    NSDictionary *errorDict = @{@"-1":@"未知错误",
                                @"-1000":@"无效的URL"};
    NSString *key = [NSString stringWithFormat:@"%zd", (long)code];
    
    return [self errorWithDomain:KErrorDomain description:errorDict[key] code:code];
}



+ (NSDictionary *)composedParameters:(NSDictionary *)parameters{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (parameters != nil) {
        [dict addEntriesFromDictionary:parameters];
    }
    return [dict copy];
}


+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        return nil;
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


+ (NSError *)errorWithDomain:(NSString *)domain description:(NSString *)description code:(NSInteger)code {
    NSError *error;
    NSDictionary *userInfo;
    if (KISNullString(description)) {
        userInfo = @{NSLocalizedDescriptionKey:@"网络异常,请稍后再试"};
    } else {
        userInfo = @{NSLocalizedDescriptionKey:description};
    }
    error = [NSError errorWithDomain:domain code:code userInfo:userInfo];
    return error;
}

+ (NSError *)dripCarErrorForAFNError:(NSError *)error {
    
    NSHTTPURLResponse *responses = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    if (responses) {
        NSInteger statusCode = responses.statusCode;
        NSString *msg = [NSString stringWithFormat:@"http %zd 错误", statusCode];
        return [self errorForServerWithMsg:msg code:@(statusCode)];
    }
    return [self errorForAPPWithCode:error.code];
}




+ (NSError *)errorForServerWithMsg:(NSString *)msg code:(NSNumber *)code {
    
    NSInteger errorCode;
    if (!code) {
        errorCode = WWServerErrorCodeUnknown;
    } else {
        errorCode = [code integerValue];
    }
    
    if (!msg) {
        msg = @"服务器 未知错误";
    }
    return [self errorWithDomain:KServerErrorDomain description:msg code:errorCode];
}


#pragma mark - networkStatus

+ (void)networkStatusWithBlock:(NetworkStatusBlock)networkStatus{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case -1:
                    networkStatus ? networkStatus(-1):nil;
                    break;
                case 0:
                    networkStatus ? networkStatus(0):nil;
                    break;
                case 1:
                    networkStatus ? networkStatus(1):nil;
                    break;
                case 2:
                    networkStatus ? networkStatus(2):nil;
                    break;
            }
        }];
    });
}

@end
