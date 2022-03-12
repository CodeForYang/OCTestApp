//
//  NSObject+YHZombiesNSObject.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/10.
//

#import "NSObject+YHZombiesNSObject.h"
#import <objc/message.h>
@implementation NSObject (YHZombiesNSObject)
+ (void)load {
    [self __YHZobiesObject];
}

+ (void)__YHZobiesObject {
    char *clsChars = "NSObject";
    Class cls = objc_lookUpClass(clsChars);
    
    Method oriM = class_getInstanceMethod(cls, NSSelectorFromString(@"dealloc"));
    Method newM = class_getInstanceMethod(cls, NSSelectorFromString(@"__YHDealloc_zombie"));
    method_exchangeImplementations(oriM, newM);
}

- (void)__YHDealloc_zombie {
    const char *className = object_getClassName(self);
    char *zombieClassName = NULL;
    asprintf(&zombieClassName, "_YHZombie_%s", className);
    Class zombieClass = objc_getClass(zombieClassName);
    
    if (zombieClass == Nil) {
        zombieClass = objc_duplicateClass(objc_getClass("_YHZombie_"), zombieClassName, 0);
    }
    
    objc_destructInstance(self);
    object_setClass(self, zombieClass);
    if (zombieClassName != NULL) {
        free(zombieClassName);
    }
}
@end
