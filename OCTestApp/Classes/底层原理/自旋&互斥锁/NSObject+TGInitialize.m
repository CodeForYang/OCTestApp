//
//  NSObject+TGInitialize.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/22.
//

#import "NSObject+TGInitialize.h"

#define FAST_DATA_MASK  0x00007ffffffffff8UL
#define RW_INITIALIZED  (1<<29)
@implementation NSObject (TGInitialize)


+ (BOOL)isUsedClass:(NSString *)cls {
    Class mCls = objc_getMetaClass(cls.UTF8String);
    if (mCls) {
        uint64_t *bits = (__bridge  void*)mCls + 32;
        uint32_t *data = (uint32_t *)(*bits & FAST_DATA_MASK);
        if (*data & RW_INITIALIZED) {
            return YES;
        }
    }
    
    return NO;
}
@end
