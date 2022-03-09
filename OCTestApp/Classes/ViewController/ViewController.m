//
//  ViewController.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "ViewController.h"
#import "TGBaseTableView.h"
#import "TGMainViewModel.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TGBaseTableView *tableView;
@property (nonatomic, strong) TGMainViewModel *vm;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (TGBaseTableView *)tableView {
    if (_tableView) return _tableView;
    
    _tableView = [[TGBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    return _tableView;
}


- (TGMainViewModel *)vm {
    if (_vm) return _vm;
    
    _vm = [TGBaseTableView new];
    
    return _tableView;
}
@end
