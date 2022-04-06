//
//  IconFontModel.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IconFontModel : NSObject <YYModel>
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *unicode;

@end

NS_ASSUME_NONNULL_END
