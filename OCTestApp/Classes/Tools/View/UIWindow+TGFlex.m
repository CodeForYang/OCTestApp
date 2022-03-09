//
//  UIWindow+TGFlex.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "UIWindow+TGFlex.h"
#import <FLEX.h>
@implementation UIWindow (TGFlex)
#if DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [super motionBegan:motion withEvent:event];
    
    if (motion == UIEventSubtypeMotionShake) {
        [[FLEXManager sharedManager] showExplorer];
    }
}

#endif
@end
