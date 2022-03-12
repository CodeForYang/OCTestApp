//
//  TGSlideSwitchHeaderView.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "TGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TGSlideSwitchHeaderViewDelegate <NSObject>

- (void)slideSegmentDidSelectIndex:(NSInteger)index;


@end


@interface TGSlideSwitchHeaderView : TGBaseView
@property (nonatomic, weak) id <TGSlideSwitchHeaderViewDelegate> delegate;


@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIColor *ItemSelectedColor;

@property (nonatomic, strong) UIColor *ItemNormalColor;

@property (nonatomic, assign) CGFloat *progress;

@property (nonatomic, assign) NSUInteger *selectedIndex;

@property (nonatomic, assign) UIButton *addButton;



@end

NS_ASSUME_NONNULL_END
