//
//  TGNetworkManager.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "TGNetworkManager.h"
#import "TGJsonFileMgr.h"
#import "TGMainModel.h"

@interface TGNetworkManager()
@property (nonatomic, strong) TGJsonFileMgr *jsonMgr;
@end
@implementation TGNetworkManager
+ (instancetype)shared {
    
    static TGNetworkManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [TGNetworkManager new];
        mgr.jsonMgr = [TGJsonFileMgr new];
    });
    
    return mgr;
}

- (void)requestWithSuccessBlock:(TGSuccessBlock)sBlock failureBlock:(TGFailureBlock)fBlock {
    id obj = [self.jsonMgr fileGet];
    
    if (obj) {
        sBlock(obj);
    } else {
        fBlock(@"文件不存在");
    }
    
}



@end
