//
//  UIView+Frame.h
//  工具分类
//
//  Created by VanJay on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//  提供直接修改frame参数

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, readonly, assign) CGFloat screenX;
@property (nonatomic, readonly, assign) CGFloat screenY;
@property (nonatomic, readonly, assign) CGFloat screenViewX;
@property (nonatomic, readonly, assign) CGFloat screenViewY;
@property (nonatomic, readonly, assign) CGRect screenFrame;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (assign, nonatomic, class, readonly) CGFloat tg_topInsets;
@property (assign, nonatomic, class, readonly) CGFloat tg_bottomInsets;
- (void)tg_setHeightConstraint:(CGFloat)height;
- (void)bringBottomConstraintFromSubview:(UIView *)fromView toSubview:(UIView *)toView constant:(CGFloat)constant;

- (void)removeAllSubviews;
- (UIViewController *)viewController;
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

+ (instancetype)loadFromNibWithBundleName:(NSString *)bundleName;
- (UIImage *)convertToImage;
- (CGFloat)bottomViewHeight;
- (CGFloat)normalBottomViewHeight;
- (CGFloat)popBoxBarHeight;
/// 半屏头部视图高度
- (CGFloat)popBoxBarHeaderHeight;

/// tab bar height
- (CGFloat)tabbarHeight;

/// navigation bar  height
- (CGFloat)navigationBarHeight;

/// tab bar height
+ (CGFloat)tabbarHeight;

/// navigation bar  height
+ (CGFloat)navigationBarHeight;

@end
