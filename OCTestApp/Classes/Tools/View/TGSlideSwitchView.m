//
//  TGSlideSwitchView.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import "TGSlideSwitchView.h"

static const CGFloat segmentH = 40.0f;

@interface TGSlideSwitchView()<
UIPageViewControllerDelegate,UIPageViewControllerDataSource, TGSlideSwitchDelegate, UIScrollViewDelegate>

@property (nonatomic, assign) BOOL showHeaderViewInNavigationBar;


@property (nonatomic, strong) UIPageViewController *pageVc;
@end

@implementation TGSlideSwitchView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.headerView = [TGSlideSwitchHeaderView new];
    
    
    self.pageVc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
}
- (void)showInViewController:(UIViewController *)viewController {
    
}

- (void)showInNavigationController:(UIViewController *)navigationController {
    
}

@end
