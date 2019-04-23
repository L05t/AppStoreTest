//
//  UtilsMacros.h
//  BaseProjectTest
//
//  Created by 武家成 on 2019/4/18.
//  Copyright © 2019 武家成. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

//static NSString *const MainColor = @"0x******";


//获取系统对象
#define KApplication        [UIApplication sharedApplication]
#define KAppWindow          [UIApplication sharedApplication].delegate.window
#define KAppDelegate        [AppDelegate shareAppDelegate]
#define KRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define KUserDefaults       [NSUserDefaults standardUserDefaults]
#define KNotificationCenter [NSNotificationCenter defaultCenter]

//弱引用

/**
Example:
@weakify(self)
[self doSomething^{
    @strongify(self)
    if (!self) return;
    ...
}];

*/
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
            #endif
    #else
            #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif






//View 圆角和加边框
#define KViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define KViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


#ifdef DEBUG
#define echo(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define echo(...)
#endif



#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]


//颜色

//不带alpha
#define KUIColorFromRGBHEX(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//带alpha
#define KUIColorFromRGBAlphaHex(rgbValue,aValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:aValue]

#define KRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)        //随机色生成
#define KMainColor KUIColorFromRGBHEX(0x010101)//app主色

//机型
#define KISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define KISiPhoneX (kISiPhone && kScreenMaxLength == 812.0)
#define KISiPhoneXr (kISiPhone && kScreenMaxLength == 896.0)
#define KISiPhoneXX (kISiPhone && kScreenMaxLength > 811.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)


//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KScreen_Bounds [UIScreen mainScreen].bounds

//状态栏高度
#define KStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//标签栏高度
#define KTabBarHeight (StatusBarHeight > 20 ? 83 : 49)
//导航栏高度
#define KNavBarHeight (StatusBarHeight + 44)
//安全区高度
#define KSafeAreaBottom (kISiPhoneXX ? 34 : 0)

//字体设置
#define KBoldFont(x) [UIFont boldSystemFontOfSize:x]
#define KFont(x) [UIFont systemFontOfSize:x]
#define KNameFont(x) [UIFont fontWithName:@"Heiti SC" size:x]


//系统对象
//APP对象 （单例对象）
#define KApplication [UIApplication sharedApplication]
//主窗口
#define KKeyWindow [UIApplication sharedApplication].keyWindow
//NSUserDefaults实例化
#define KUserDefaults [NSUserDefaults standardUserDefaults]
//通知中心 （单例对象）
#define KNotificationCenter [NSNotificationCenter defaultCenter]
//发送通知
#define KPostNotification(name,obj,info) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:info]
//APP版本号
#define KVersion [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
//系统版本号
#define KSystemVersion [[UIDevice currentDevice] systemVersion]


//永久存储对象
#define KSetUserDefaults(object, key)({\                            \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];  \
[defaults setObject:object forKey:key];                             \
[defaults synchronize];                                             \
})
//获取对象
#define KGetUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
//删除某一个对象
#define KRemoveUserDefaults(key)                                         \
({                                                                          \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults removeObjectForKey:_key];                                     \
[defaults synchronize];                                                 \
})
//清除 NSUserDefaults 保存的所有数据
#define KRemoveAllUserDefaults  [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]]

//字符串是否为空
#define KISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define KISNullArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
//字典是否为空
#define KISNullDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
//是否是空对象
#define KISNullObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//判断对象是否为空,为空则返回默认值
#define KGetNullDefaultObj(_value,_default) ([_value isKindOfClass:[NSNull class]] || !_value || _value == nil || [_value isEqualToString:@"(null)"] || [_value isEqualToString:@"<null>"] || [_value isEqualToString:@""] || [_value length] == 0)?_default:_value

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}



#endif /* UtilsMacros_h */
