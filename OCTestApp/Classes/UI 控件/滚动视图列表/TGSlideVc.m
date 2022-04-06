//
//  TGSlideVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import "TGSlideVc.h"
#import "TGSlideSwitchView.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
@interface TGSlideVc ()

@property (nonatomic, strong) TGSlideSwitchView *slideSwitch;
@end

@implementation TGSlideVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup1];
}

- (void)setup1 {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(showNextView)];
    NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < titles.count; i++) {
        [vcs addObject:[self viewControllerOfIndex:i]];
    }
    
    _slideSwitch = [TGSlideSwitchView new];
    _slideSwitch.viewControllers = vcs;
    _slideSwitch.titles = titles;
    _slideSwitch.selectedIdx = 0;
    CGFloat y = UIView.tg_topInsets + 44;
    _slideSwitch.frame = CGRectMake(0, y, UIView.screenW, UIView.screenH - y);
    _slideSwitch.headerView.ItemNormalColor = [UIColor darkGrayColor];
    _slideSwitch.headerView.ItemSelectedColor = self.navigationController.navigationBar.tintColor;
    
    _slideSwitch.headerView.customMargin = 30;
    _slideSwitch.headerView.addButton = [self addButton];
    [_slideSwitch showInViewController:self];
}

- (UIButton *)addButton {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b addTarget:self action:@selector(OnClick) forControlEvents:UIControlEventTouchUpInside];
    [b setTitle:@"添加" forState:UIControlStateNormal];
    return b;
}

- (void)OnClick{}

- (UIViewController *)viewControllerOfIndex:(NSInteger)index {
    if (index % 2 == 0) {
        return [TableViewController new];
    }
    
    return [CollectionViewController new];
}



- (void)showNextView {
    _slideSwitch.headerView.selectedIndex += 1;
}
@end


@implementation TGFormatterModel

- (instancetype)initWithViewControllers:(UIViewController *)firstVc, ... {
    if (self = [super init]) {
        NSMutableArray *params = [NSMutableArray array];
        
        va_list argumentsList;
        if (firstVc) {
            [params addObject:firstVc];
            va_start(argumentsList, firstVc);
            
            NSString *eachObject;
            
            while ((eachObject = va_arg(argumentsList, NSString *))) {
                [params addObject:eachObject];
                va_end(argumentsList);
            }
        }
    }
    
    return self;
}

@end
