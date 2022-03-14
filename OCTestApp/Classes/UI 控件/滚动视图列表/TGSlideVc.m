//
//  TGSlideVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import "TGSlideVc.h"
#import "TGSlideSwitchView.h"

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
        <#statements#>
    }
}

- (void)showNextView {
    _slideSwitch.headerView.selectedIndex += 1;
}
@end
