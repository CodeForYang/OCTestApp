//
//  TGSlideSwitchView.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import "TGSlideSwitchView.h"

static const CGFloat segmentH = 40.0f;

@interface TGSlideSwitchView()<
UIPageViewControllerDelegate,UIPageViewControllerDataSource, TGSlideSwitchDelegate, UIScrollViewDelegate, TGSlideSwitchHeaderViewDelegate>

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
    self.headerView.delegate = self;
    
    self.pageVc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVc.delegate = self;
    self.pageVc.dataSource = self;
    [self addSubview:_pageVc.view];
    
    for (UIScrollView *s in _pageVc.view.subviews) {
        if ([s isKindOfClass:[UIScrollView class]]) {
            s.delegate = self;
        }
    }
    
}
- (void)showInViewController:(UIViewController *)viewController {
    [viewController addChildViewController:_pageVc];
    [viewController.view addSubview:self];
}

- (void)showInNavigationController:(UINavigationController *)navigationController {
    [navigationController.topViewController.view addSubview:self];
    [navigationController.topViewController addChildViewController:_pageVc];
    navigationController.topViewController.navigationItem.titleView = _headerView;
    _pageVc.view.frame = self.bounds;
    _headerView.showTitlesInNavBar = YES;
    _showHeaderViewInNavigationBar = YES;
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    
    UIViewController *vc = nil;
    if (_selectedIdx < _titles.count - 1) {
        vc = _viewControllers[_selectedIdx];
        vc.view.bounds = pageViewController.view.bounds;
    }
    
    return vc;
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    <#code#>
}

- (void)slideSwitchDidSelectIndex:(NSInteger)index {
    <#code#>
}

- (void)slideSegmentDidSelectIndex:(NSInteger)index {
    <#code#>
}


@end
