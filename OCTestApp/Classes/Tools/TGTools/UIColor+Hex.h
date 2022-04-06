//
//  UIColor+Hex.h
//  TGCRMKit
//
//  Created by Clark on 2019/7/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;
@end

NS_ASSUME_NONNULL_END
