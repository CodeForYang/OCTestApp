//
//  TGMainViewModel.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "TGMainViewModel.h"
#import "TGNetworkManager.h"
#import <YYModel.h>
@interface TGMainViewModel()

@end
@implementation TGMainViewModel
- (void)getDataWithSucessBlock:(void (^)(TGMainModel * _Nonnull))block {
    
    self.isRequestDone = NO;
    [TGNetworkManager.shared requestWithSuccessBlock:^(id  _Nonnull obj) {

        self.model = [TGMainModel yy_modelWithJSON:obj[@"data"]];
        block(self.model);
    } failureBlock:^(id  _Nonnull obj) {
        TGLog(@"==#==%@", obj);
    }];
}
@end
