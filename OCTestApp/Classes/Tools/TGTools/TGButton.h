//
//  TGButton.h
//  TGICardKit
//
//  Created by jf on 2019/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TGButtonImageAlignment) {
    TGButtonImageAlignmentLeft = 0,
    TGButtonImageAlignmentTop,
    TGButtonImageAlignmentBottom,
    TGButtonImageAlignmentRight,
};

@interface TGButton : UIButton

@property (nonatomic, assign) TGButtonImageAlignment imageAlignment;
@property (nonatomic, assign) CGFloat spaceBetweenTitleAndImage;

/// 导航栏中间 文字 - 按钮
+ (instancetype)navigationSelectionButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
-(void)tg_clipWithCornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
