//
//  TGNetworkManager.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TGSuccessBlock)(id obj);
typedef void(^TGFailureBlock)(id obj);

@interface TGNetworkManager : NSObject
+ (instancetype)sharedWith:(NSString *)fileName;
- (void)requestWithSuccessBlock:(TGSuccessBlock)sBlock failureBlock:(TGFailureBlock)fBlock;
@end

NS_ASSUME_NONNULL_END
