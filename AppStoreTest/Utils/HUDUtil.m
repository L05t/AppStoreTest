//
//  HUDUtil.m
//  AppStoreTest
//
//  Created by 武家成 on 2019/4/23.
//  Copyright © 2019 武家成. All rights reserved.
//

#import "HUDUtil.h"
#import <SVProgressHUD/SVProgressHUD.h>


@implementation HUDUtil


+ (void)showLoading{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
}

+ (void)showLoading:(NSString *)msg{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:msg];

}

+ (void)showLoading:(NSString *)msg isAllowTouch:(BOOL)isAllowTouch{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:15]];
    if (isAllowTouch) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }else{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    [SVProgressHUD showWithStatus:msg];

}

+ (void)showSuccess:(NSString *)msg{
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:15]];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showSuccessWithStatus:msg];

}

+ (void)showInfo:(NSString *)msg{
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:15]];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showInfoWithStatus:msg];
}

+ (void)showError:(NSString *)msg{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showInfoWithStatus:msg];

}

+ (void)hide{
    [SVProgressHUD dismiss];

}

+ (void)hideWithTime:(NSTimeInterval)time{
    [SVProgressHUD dismissWithDelay:time];

}

+ (void)showLoadProgress:(NSString *)msg progress:(float)progress isAllowTouch:(BOOL)isAllowTouch{
    if (isAllowTouch) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        
    }else{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    [SVProgressHUD showProgress:progress status:msg];
}


@end
