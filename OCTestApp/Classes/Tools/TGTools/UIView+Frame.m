//
//  UIView+Frame.m
//  工具分类
//
//  Created by VanJay on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "UIView+Frame.h"
#import "UtilsMacros.h"

@implementation UIView (Frame)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)screenX {
    CGFloat x = 0;
    for (UIView *view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY {
    CGFloat y = 0;
    for (UIView *view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView *view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView *view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

+ (CGFloat)tg_topInsets{
    CGFloat statusBarHeight = 0;
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (keyWindow) {
            statusBarHeight = keyWindow.safeAreaInsets.top;
        }
    }
    if (statusBarHeight == 0) {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

+ (CGFloat)tg_bottomInsets{
    if (@available(iOS 11.0, *)) {
        UIView *v = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        if (v) {
            return v.safeAreaInsets.bottom;
        }
        
    }
    return 0;
}

- (void)tg_setHeightConstraint:(CGFloat)height {
    if (height > MAXFLOAT || height < 0 || height == NSNotFound) {
        return;
    }
    BOOL hasHeightCons = NO;
    for (NSLayoutConstraint *cons in self.constraints) {
        if (cons.firstItem == self && cons.secondItem == nil && cons.firstAttribute == NSLayoutAttributeHeight) {
            cons.constant = height;
            hasHeightCons = YES;
            break;
        }
    }
    if (!hasHeightCons) {
        NSLayoutConstraint *cons = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
        [self addConstraint:cons];
    }
}

- (void)bringBottomConstraintFromSubview:(UIView *)fromView toSubview:(UIView *)toView constant:(CGFloat)constant{
    for (NSLayoutConstraint *cons in self.constraints) {
        if (cons.firstAttribute == NSLayoutAttributeBottom && cons.secondAttribute == NSLayoutAttributeBottom) {
            if (cons.firstItem == fromView || cons.secondItem == fromView || cons.firstItem == toView || cons.secondItem == toView) {
                [self removeConstraint:cons];
            }
            NSLayoutConstraint *newCons = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:toView attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
            [self addConstraint:newCons];
        }
    }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)nextResponder;
    } else {
        return nil;
    }
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

+ (instancetype)loadFromNibWithBundleName:(NSString *)bundleName {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:bundleName ofType:@"bundle"];
    NSBundle *bundle = path ? [NSBundle bundleWithPath:path] : [NSBundle mainBundle];
    NSString *className = [NSStringFromClass([self class]) componentsSeparatedByString:@"."].lastObject;
    return ([bundle loadNibNamed:className owner:nil options:nil].firstObject);
}

- (UIImage *)convertToImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (CGFloat)bottomViewHeight {
    CGFloat height = 68 + [UIView tg_bottomInsets];
    return height;
}

- (CGFloat)normalBottomViewHeight {
    return 68;
}

- (CGFloat)popBoxBarHeight {
    if ([UIView tg_bottomInsets]) {
        return 49+34;
    }
    return 65.f;
}

- (CGFloat)popBoxBarHeaderHeight {
    return 51;
}

/// tab bar height
- (CGFloat)tabbarHeight {
    return 52 + UIView.tg_bottomInsets;
}

/// navigation bar  height
- (CGFloat)navigationBarHeight {
    return 52 + UIView.tg_topInsets;
}

/// tab bar height
+ (CGFloat)tabbarHeight {
    return 52 + UIView.tg_bottomInsets;
}

/// navigation bar  height
+ (CGFloat)navigationBarHeight {
    return 52 + UIView.tg_topInsets;
}

@end

