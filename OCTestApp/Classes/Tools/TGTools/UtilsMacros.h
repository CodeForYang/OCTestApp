//
//  UtilsMacros.h
//  Tungee
//
//  Created by VanJay on 2018/8/17.
//  Copyright © 2018年 Tungee. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

// RGB颜色
#define WJColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a) / 1.0]
// 随机色
#define WJRandomColor WJColor(arc4random_uniform(256.0), arc4random_uniform(256.0), arc4random_uniform(256.0), 1)

//获取系统对象
#define kApplication [UIApplication sharedApplication]
#define kAppWindow [UIApplication sharedApplication].delegate.window
#define kAppDelegate [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//获取屏幕宽高
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenBounds [UIScreen mainScreen].bounds

#define SCREEN_MAX_LENGTH (MAX(kScreenWidth, kScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(kScreenWidth, kScreenHeight))

#define kWidthCoefficientTo6S kScreenWidth / 375.0
#define kHeightCoefficientTo6S (kScreenHeight == 812.0 ? 667.0 / 667.0 : kScreenHeight / 667.0)

//根据ip6s的屏幕来拉伸
#define kRealWidth(with) ((with) * (kWidthCoefficientTo6S))
#define kRealHeight(with) ((with) * (kHeightCoefficientTo6S))

#define frameString(...) NSStringFromCGRect(__VA_ARGS__)
#define pointString(...) NSStringFromCGPoint(__VA_ARGS__)

// 强弱引用
#define kWeakObj(type) __weak typeof(type) weak_##type = type
#define kStrongObj(type) __strong typeof(type) type = weak_##type

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color) \
                                                     \
    [View.layer setCornerRadius:(Radius)];           \
    [View.layer setMasksToBounds:YES];               \
    [View.layer setBorderWidth:(Width)];             \
    [View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)           \
                                           \
    [View.layer setCornerRadius:(Radius)]; \
    [View.layer setMasksToBounds:YES]

// property 属性快速声明 别用宏定义了，使用代码块+快捷键实现吧

// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

//-------------------打印日志-------------------------
// DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define TGLog(fmt, ...) fprintf(stderr, "\n%s:%d\t%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String])
#else
#define TGLog(...)
#endif

//拼接字符串
#define NSStringFormat(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]

//颜色
#define kClearColor [UIColor clearColor]
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kGrayColor [UIColor grayColor]
#define kGray2Color [UIColor lightGrayColor]
#define kBlueColor [UIColor blueColor]
#define kRedColor [UIColor redColor]
#define kRandomColor                                                            \
    KRGBColor(arc4random_uniform(256) / 255.0, arc4random_uniform(256) / 255.0, \
              arc4random_uniform(256) / 255.0)  //随机色生成

//字体
#define BOLDSYSTEMFONT(fontsize) [UIFont boldSystemFontOfSize:fontsize]
#define SYSTEMFONT(fontsize) [UIFont systemFontOfSize:fontsize]
#define FONT(name, fontsize) [UIFont fontWithName:(name) size:(fontsize)]

//定义UIImage对象
#define ImageWithFile(_pointer)                                                                                        \
    [UIImage                                                                                                           \
        imageWithContentsOfFile:([[NSBundle mainBundle]                                                                \
                                    pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer,                    \
                                                                               (int)[UIScreen mainScreen].nativeScale] \
                                             ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

//数据验证
#define StrValid(f) (f != nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f : @"")
#define HasString(str, key) ([str rangeOfString:key].location != NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f != nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f != nil && [f isKindOfClass:[NSArray class]] && [f count] > 0)
#define ValidNum(f) (f != nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f, cls) (f != nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f != nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent()
#define kEndTime TGLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)
//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//发送通知
#define kPostNotification(name, obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj]

#define kPostNotificationWithInfo(name, obj, info) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:info]

//单例化一个类
#define SINGLETON_FOR_HEADER(className) +(className *)shared##className

#define SINGLETON_FOR_CLASS(className)               \
                                                     \
    +(className *)shared##className {                \
        static className *shared##className = nil;   \
        static dispatch_once_t onceToken;            \
        dispatch_once(&onceToken, ^{                 \
            shared##className = [[self alloc] init]; \
        });                                          \
        return shared##className;                    \
    }

#define fx_dispatch_main_sync_safe(block)                \
    if ([NSThread isMainThread]) {                       \
        block();                                         \
    } else {                                             \
        dispatch_sync(dispatch_get_main_queue(), block); \
    }

#define fx_dispatch_main_async_safe(block)                \
    if ([NSThread isMainThread]) {                        \
        block();                                          \
    } else {                                              \
        dispatch_async(dispatch_get_main_queue(), block); \
    }
#endif /* UtilsMacros_h */
