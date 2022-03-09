//
//  TGMainModel.h
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface TGTitleModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *icon;
@end


@interface TGMainSubModel : NSObject<YYModel>

@property (nonatomic, strong) NSString *section_name;
@property (nonatomic, strong) NSArray <TGTitleModel *>*detail;
@end

@interface TGMainModel : NSObject<YYModel>

@property (nonatomic, strong) NSArray <TGMainSubModel *>*items;
@end


NS_ASSUME_NONNULL_END
