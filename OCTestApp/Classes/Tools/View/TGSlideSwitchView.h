//
//  TGSlideSwitchView.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "TGSlideSwitchHeaderView.h"
#import "TGBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TGSlideSwitchDelegate <NSObject>

- (void)slideSwitchDidSelectIndex:(NSInteger)index;

@end


@interface TGSlideSwitchView : TGBaseView

@property (nonatomic, strong) NSArray *viewController;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) NSUInteger selectedIdx;


@property (nonatomic, strong) TGSlideSwitchHeaderView *headerView;

@property (nonatomic, weak) id <TGSlideSwitchDelegate> delegate;

- (void)showInViewController:(UIViewController *)viewController;

- (void)showInNavigationController:(UIViewController *)navigationController;


@end

NS_ASSUME_NONNULL_END
