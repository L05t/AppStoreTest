//
//  AppDelegate+category.m
//  AppStoreTest
//
//  Created by 武家成 on 2019/4/19.
//  Copyright © 2019 武家成. All rights reserved.
//

#import "AppDelegate+category.h"
#import "UtilsMacros.h"

@implementation AppDelegate (category)


- (void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:KScreen_Bounds];
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    
    
    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[HUDUtil class]]].color = KUIColorFromRGBHEX(0x1010101);
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}



- (void)initService{
    [KNotificationCenter addObserver:self selector:@selector(logStatusChange:) name:KNotificationLoginStateChange object:nil];
    [KNotificationCenter addObserver:self selector:@selector(networkStatusChange:) name:KNotificationNetWorkStateChange object:nil];
}

#pragma mark - networkStatusObserver

- (void)networkStatusObserverFunc{
    [NetworkAPIClient networkStatusWithBlock:^(NetworkStatus status) {
        switch (status) {
            case -1:
                echo(@"网络环境:未知网络");
                break;
            case 0:
                echo(@"网络环境:无网络");
                KPostNotification(KNotificationNetWorkStateChange, nil, @{@"keyword":@0});
                break;
            case 1:
                echo(@"网络环境:移动蜂窝网络");
                KPostNotification(KNotificationNetWorkStateChange, nil, @{@"keyword":@1});
                break;
            case 2:
                echo(@"网络环境:WIFI");
                KPostNotification(KNotificationNetWorkStateChange, nil, @{@"keyword":@2});
                break;
        }
    }];
}



#pragma mark - initServiceFunc

- (void)logStatusChange:(NSNotification *)notification{
    if ([notification.object boolValue]) {
        //登录成功
    }else{
        //登录失败 跳转登录
    }
}

- (void)networkStatusChange:(NSNotification *)notification{
    if ([notification.object boolValue]) {
        //有网络
    }else{
        [HUDUtil showInfo:@"网络状态不佳"];
    }
}


@end

