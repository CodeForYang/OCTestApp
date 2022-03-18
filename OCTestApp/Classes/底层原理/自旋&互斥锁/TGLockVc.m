//
//  TGLockVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/18.
//

#import "TGLockVc.h"

@interface TGLockVc ()

@end

@implementation TGLockVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    TGLockManager *mgr = TGLockManager.shared;
    
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);

    NSLog(@"Linked in %f ms - %@", linkTime *1000.0, mgr);


    CFAbsoluteTime startTime1 = CFAbsoluteTimeGetCurrent();
    
    TGLockManager *mgr1 = TGLockManager.shared1;

    CFAbsoluteTime linkTime1 = (CFAbsoluteTimeGetCurrent() - startTime1);

    NSLog(@"Linked in %f ms - %@", linkTime1 *1000.0, mgr1);
    

}



@end


@implementation TGLockManager

static id obj = nil;
+ (instancetype)shared {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [TGLockManager new];
    });
    
    return obj;
}

static id obj1 = nil;
+ (instancetype)shared1 {

    @synchronized (self) {
        if (!obj1) {
            obj1 = [TGLockManager new];
        }
    }
    
    return obj1;
}

@end
