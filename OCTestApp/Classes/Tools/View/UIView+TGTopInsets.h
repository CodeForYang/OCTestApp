//
//  UIView+TGTopInsets.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TGTopInsets)
+ (CGFloat)tg_topInsets ;
+ (CGFloat)tg_bottomInsets;
+ (CGFloat)screenW ;
+ (CGFloat)screenH;
@end

NS_ASSUME_NONNULL_END
