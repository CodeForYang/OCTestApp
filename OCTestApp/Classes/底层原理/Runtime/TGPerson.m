//
//  TGPerson.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/4/8.
//

#import "TGPerson.h"
#import <objc/message.h>

@implementation RuntimeMethod
- (void)method2 {
    NSLog(@"%@, %p", self, _cmd);
}

@end

void dynamicMethodIMP(id self, SEL _cmd) {}

@interface TGPerson (){
    RuntimeMethod *_helper;
}

@end
@implementation TGPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        _helper = [RuntimeMethod new];
    }
    return self;
}
//MARK: ====================动态方法解析
void functionForMethod1(id self, SEL _cmd) {
    NSLog(@"%@ %p", self, _cmd);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selStr = NSStringFromSelector(sel);
    if ([selStr  isEqualToString:@"method1"]) {//新增该方法
        class_addMethod(self.class, @selector(method1), (IMP)functionForMethod1, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

//MARK: ====================重定向接收者

//- (id)forwardingTargetForSelector:(SEL)aSelector {//让其他的类响应方法
//    if (aSelector == @selector(method2)) {
//        return _helper;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

//MARK: ====================消息转发
//先方法签名-再调用target
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *s = [super methodSignatureForSelector:aSelector];
    if (!s && [RuntimeMethod instancesRespondToSelector:aSelector]) {
        s = [RuntimeMethod instanceMethodSignatureForSelector:aSelector];
    }
    
    return s;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([RuntimeMethod instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_helper];
    }
}



@end
