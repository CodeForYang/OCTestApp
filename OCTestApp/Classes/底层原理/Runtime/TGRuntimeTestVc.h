//
//  TGRuntimeTestVc.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/4/6.
//

#import "TGViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGRuntimeTestVc : TGViewController

@end

@interface TGSark : NSObject<NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSString *string;

@property (nonatomic, strong) NSString *name;

- (void)method1;
- (void)method2;
+ (void)classMethod;


@end
NS_ASSUME_NONNULL_END
