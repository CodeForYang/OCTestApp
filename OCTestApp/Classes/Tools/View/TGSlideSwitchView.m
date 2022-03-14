//
//  TGSlideSwitchView.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import "TGSlideSwitchView.h"

static const CGFloat segmentH = 40.0f;

@interface TGSlideSwitchView()<
UIPageViewControllerDelegate,UIPageViewControllerDataSource, UIScrollViewDelegate, TGSlideSwitchHeaderViewDelegate>

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

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    _selectedIdx = [_viewControllers indexOfObject:pageViewController.viewControllers.firstObject];
    _headerView.selectedIndex = _selectedIdx;
    [self performSwitchDelegateMethod];
}

- (void)performSwitchDelegateMethod {
    if ([self.delegate respondsToSelector:@selector(slideSwitchDidSelectIndex:)]) {
        [_delegate slideSwitchDidSelectIndex:_selectedIdx];
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
        vc = _viewControllers[_selectedIdx + 1];
        vc.view.bounds = pageViewController.view.bounds;
    }
    
    return vc;
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    
    UIViewController *vc = nil;
    if (_selectedIdx > 0) {
        vc = _viewControllers[_selectedIdx - 1];
        vc.view.bounds = pageViewController.view.bounds;
    }
    
    return vc;
}


- (void)slideSegmentDidSelectIndex:(NSInteger)index {
    if (index == _selectedIdx) return;
    
    [self switchToIndex:index];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == scrollView.bounds.size.width) return;
    CGFloat p = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _headerView.progress = p;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _headerView.ignoreAnimation = NO;
}

//pageView方向
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationPortrait;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _headerView.frame = CGRectMake(0, 0, self.frame.size.width, segmentH);
    _pageVc.view.frame = CGRectMake(0, segmentH, self.frame.size.width, self.frame.size.height - segmentH);
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self switchToIndex: _selectedIdx];
}

- (void)switchToIndex:(NSInteger)idx {
    __weak typeof(self)weakSelf = self;
    
    [_pageVc setViewControllers:@[_viewControllers[idx]] direction:idx < _selectedIdx animated:YES completion:^(BOOL finished) {
        weakSelf.selectedIdx = idx;
        [weakSelf performSwitchDelegateMethod];
    }];
}


@end
