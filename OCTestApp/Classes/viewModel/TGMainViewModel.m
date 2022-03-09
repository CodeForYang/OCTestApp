//
//  TGMainViewModel.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "TGMainViewModel.h"
#import "TGNetworkManager.h"
@interface TGMainViewModel()

@end
@implementation TGMainViewModel
- (void)getData {
    TGNetworkManager.shared.requestWithSuccessBlock:^(id  _Nonnull obj) {
        <#code#>
    } failureBlock:^(id  _Nonnull obj) {
        <#code#>
    }
}
@end
