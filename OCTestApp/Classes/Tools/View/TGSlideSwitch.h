//
//  TGSlideSwitch.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TGSlideSwitchDelegate <NSObject>

- (void)slideSwitchDidSelectIndex:(NSInteger)index;

@end


@interface TGSlideSwitch : UIView

@end

NS_ASSUME_NONNULL_END
