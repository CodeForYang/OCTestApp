//
//  TGLockVc.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/18.
//

#import "TGViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGLockVc : TGViewController

@end

@interface TGLockManager : NSObject
+ (instancetype)shared;
+ (instancetype)shared1;

@end


NS_ASSUME_NONNULL_END
