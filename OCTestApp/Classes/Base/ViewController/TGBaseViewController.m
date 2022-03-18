//
//  ViewController.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "TGBaseViewController.h"
#import "TGBaseTableView.h"
#import "TGMainViewModel.h"
#import <ReactiveObjC.h>
#import "TGMainTitleCell.h"
#import "ZoobieVc.h"
#import "TGViewController.h"
#import "TGLockVc.h"

@interface TGBaseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TGBaseTableView *tableView;
@property (nonatomic, strong) TGMainViewModel *vm;

@end

@implementation TGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主界面";
    [self defaultConfig];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [RACObserve(self, vm.isRequestDone) subscribeNext:^(id  _Nullable x) {
        if (self.vm.isRequestDone == NO) {return;}
        [self.tableView reloadData];
    }];
    
    [self.vm getDataWithSucessBlock:^(TGMainModel * _Nonnull model) {
        TGLog(@"request - success");
//        [self.tableView reloadData];
    }];

    NSString *clsName = TGUserDefaultsGet(TGJumpVcKey);
    if (clsName) {
        [self.navigationController pushViewController:[NSClassFromString(clsName) new] animated:NO];
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
//    UISwitch *s = [UISwitch new];
//    [self.tableView addSubview:s];
//    s.onTintColor = [UIColor redColor];
//    s.tintColor = [UIColor greenColor];//边缘
//    s.backgroundColor = [UIColor greenColor];
//    s.layer.cornerRadius = s.frame.size.height/2.0;
//    s.layer.masksToBounds = true;
    

}

- (void)defaultConfig {
    [self.tableView registerClass:[TGMainTitleCell class] forCellReuseIdentifier:@"TGMainTitleCell"];
}





- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TGMainTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TGMainTitleCell"];
    TGTitleModel *item = self.vm.model.items[indexPath.section].detail[indexPath.row];
    cell.item = item;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.model.items[section].detail.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.vm.model.items.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TGMainSubModel *mode = self.vm.model.items[section];
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    l.text = mode.section_name;
    [v addSubview:l];
    
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[ZoobieVc new] animated:YES];
        } else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[TGLockVc new] animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return  70;}

- (TGBaseTableView *)tableView {
    if (_tableView) return _tableView;
    
    _tableView = [[TGBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    return _tableView;
}

- (TGMainViewModel *)vm {
    if (_vm) return _vm;
    _vm = [TGMainViewModel new];
    return _vm;
}
@end
