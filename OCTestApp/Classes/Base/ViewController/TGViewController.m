//
//  TGViewController.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/11.
//

#import "TGViewController.h"

@interface TGViewController ()

@end

@implementation TGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc]initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(rightClearItemClick)];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:@selector(rightSelectClick)];

    self.navigationItem.rightBarButtonItems = @[clearItem, addItem];
}

- (void)rightClearItemClick {

    TGUserDefaultsSet(nil, TGJumpVcKey);
}


- (void)rightSelectClick {
    
    TGUserDefaultsSet(NSStringFromClass(self.class), TGJumpVcKey);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
