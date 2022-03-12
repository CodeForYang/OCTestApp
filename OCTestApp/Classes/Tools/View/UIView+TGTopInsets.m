//
//  UIView+TGTopInsets.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import "UIView+TGTopInsets.h"

@implementation UIView (TGTopInsets)
+ (CGFloat)tg_topInsets {
    CGFloat topInsets = 0;
    CGFloat statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height;

    if (@available(iOS 11.0, *)) {
        topInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    } else {
        return statusBarH;
    }
    
    return (topInsets > 0) ? topInsets : statusBarH;
}

+ (CGFloat)tg_bottomInsets {

    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    
    return 0;
}

@end
