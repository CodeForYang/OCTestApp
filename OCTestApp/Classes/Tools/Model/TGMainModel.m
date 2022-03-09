//
//  TGMainModel.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "TGMainModel.h"

@implementation TGTitleModel

@end


@implementation TGMainSubModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"detail" : [TGTitleModel classForCoder]};
}
@end

@implementation TGMainModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"items" : [TGMainSubModel classForCoder]};
}
@end
