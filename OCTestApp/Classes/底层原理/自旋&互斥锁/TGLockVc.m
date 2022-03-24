//
//  TGLockVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/18.
//

#import "TGLockVc.h"

@interface TGLockVc ()

@property (nonatomic, strong) NSString *name;
@end

@implementation TGLockVc

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    

}

- (void)setName:(NSString *)name {
    _name = name;
    
    NSLog(@"%s", __func__);

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"%s", __func__);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.name = @"奥斯特洛夫斯基";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self toastMsg];
    });
}



- (void)testTime {
    
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



- (void)toastMsg {
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    NSLog(@"%s", __func__);

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
