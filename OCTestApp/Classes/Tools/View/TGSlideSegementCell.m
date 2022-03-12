//
//  TGSlideSegementCell.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import "TGSlideSegementCell.h"

@implementation TGSlideSegementCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
}


@end
