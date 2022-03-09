//
//  TGNetworkManager.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "TGNetworkManager.h"

@implementation TGNetworkManager
+ (instancetype)shared {
    
    static TGNetworkManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [TGNetworkManager new];
    });
    
    return mgr;
}



@end
