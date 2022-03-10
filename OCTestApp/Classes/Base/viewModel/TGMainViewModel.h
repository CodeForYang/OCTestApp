//
//  TGMainViewModel.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import <Foundation/Foundation.h>
#import "TGMainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGMainViewModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) TGMainModel *model;
@property (nonatomic, assign) BOOL isRequestDone;
- (void)getDataWithSucessBlock:(void(^)(TGMainModel *model))block;
@end

NS_ASSUME_NONNULL_END
