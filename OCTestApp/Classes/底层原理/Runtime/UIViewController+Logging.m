//
//  UIViewController+Logging.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/4/8.
//

#import "UIViewController+Logging.h"

@implementation UIViewController (Logging)

void swizzleMethod(Class class, SEL oriSel,SEL swizSel) {
    Method oriMethod = class_getInstanceMethod(class, oriSel);
    Method swiMethod = class_getInstanceMethod(class, swizSel);
    BOOL isAdded = class_addMethod(class, oriSel, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    if (isAdded) {
        class_replaceMethod(class, swizSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swiMethod);
    }
}
- (void)swizzled_ViewDidAppear:(BOOL)animated {
    [self swizzled_ViewDidAppear:animated];
    NSLog(@"logwithEventName: %@",self.class);
}


//更简化直接用新的IMP取代原IMP，不是替换，只需要有全局的函数指针指向原IMP即可。
void (gOriginalViewDidAppear)(id, SEL, BOOL);//搞一个函数地址

void newViewDidAppear(UIViewController *self, SEL _cmd, BOOL animated)
{ // call original implementation
     gOriginalViewDidAppear(self, _cmd, animated); // Logging
    NSLog(@"logwithEventName1: %@",self.class);
}



+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod(self.class, @selector(viewWillAppear:), @selector(swizzled_ViewDidAppear:));
    });
    
//    Method oriM = class_getInstanceMethod(self, @selector(viewDidAppear:));
//    gOriginalViewDidAppear = (void *)method_getImplementation(oriM);
//
//    if (!class_addMethod(self, @selector(viewWillAppear:), (IMP)newViewDidAppear, method_getTypeEncoding(oriM))) {
//        method_setImplementation(oriM, (IMP)newViewDidAppear);
//    }
    
}


@end
