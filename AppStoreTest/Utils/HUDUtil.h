//
//  HUDUtil.h
//  AppStoreTest
//
//  Created by 武家成 on 2019/4/23.
//  Copyright © 2019 武家成. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUDUtil : NSObject

+ (void)showLoading;

+ (void)showLoading:(NSString *)msg;

+ (void)showLoading:(NSString *)msg isAllowTouch:(BOOL)isAllowTouch;

+ (void)showSuccess:(NSString *)msg;

+ (void)showInfo:(NSString *)msg;

+ (void)showError:(NSString *)msg;

+ (void)hide;

+ (void)hideWithTime:(NSTimeInterval)time;

+ (void)showLoadProgress:(NSString *)msg progress:(float)progress isAllowTouch:(BOOL)isAllowTouch;


@end

NS_ASSUME_NONNULL_END
