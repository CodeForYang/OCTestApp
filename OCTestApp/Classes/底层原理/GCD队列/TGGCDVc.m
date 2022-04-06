//
//  TGGCDVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/29.
//

#import "TGGCDVc.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <objc/objc.h>
@interface TGGCDVc ()

@end

@implementation TGGCDVc


extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));
// pthread_mutex_lock
void dispatch_once_pthread(dispatch_once_t *, dispatch_block_t);

// spinlock
void dispatch_once_spinlock(dispatch_once_t *, dispatch_block_t);


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void) onShow {
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    dispatch_queue_t dataQueue = dispatch_queue_create("aabbcc", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 999; i++) {
//        dispatch_async(dataQueue, ^{
//            NSLog(@"%@", [NSThread currentThread]);
//        });
//    }
//    [self dispatchBlockCancel];
}

- (void)dispatchBlockCancel {
    
    size_t count = 1000000;
        
    // pthread_mutex_lock
    uint64_t time1 = dispatch_benchmark(count, ^{
        static dispatch_once_t onceToken;
        dispatch_once_pthread(&onceToken, ^{ });
    });
    NSLog(@"dispatch_once_pthread = %llu ns", time1);
    
    // spinlock
    uint64_t time2 = dispatch_benchmark(count, ^{
        static dispatch_once_t onceToken;
        dispatch_once_spinlock(&onceToken, ^{ });
    });
    NSLog(@"dispatch_once_spinlock = %llu ns", time2);
    
    // dispatch_once
    uint64_t time3 = dispatch_benchmark(count, ^{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{ });
    });
    NSLog(@"dispatch_once = %llu ns", time3);
    
    /*
     2022-03-30 16:47:47.793240+0800 OCTestApp[6268:342993] dispatch_once_pthread = 25 ns
     2022-03-30 16:47:47.821279+0800 OCTestApp[6268:342993] dispatch_once_spinlock = 26 ns
     2022-03-30 16:47:47.840289+0800 OCTestApp[6268:342993] dispatch_once = 17 ns
     */
}


// pthread_mutex_lock
void dispatch_once_pthread(dispatch_once_t *predicate, dispatch_block_t block) {
    static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    pthread_mutex_lock(&mutex);
    if(!*predicate) {
        block();
        *predicate = 1;
    }
    pthread_mutex_unlock(&mutex);
}

// spinlock
void dispatch_once_spinlock(dispatch_once_t *predicate, dispatch_block_t block) {
    static OSSpinLock lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&lock);
    if(!*predicate) {
        block();
        *predicate = 1;
    }
    OSSpinLockUnlock(&lock);
}


- (void)dispatchGroupWait {
    dispatch_queue_t sQueue = dispatch_queue_create("aabbcc", NULL);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"start");
        [NSThread sleepForTimeInterval:1.5];
        NSLog(@"end");
    });
    
    dispatch_async(sQueue, block);
    
    dispatch_block_wait(block, DISPATCH_TIME_NOW);//DISPATCH_TIME_FOREVER 会阻塞线程
    NSLog(@"xxhh");
}


- (void)dispatchApplyTest {
    dispatch_queue_t dataQueue = dispatch_queue_create("aabbcc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(999, dataQueue, ^(size_t i) {
        NSLog(@"%zu - %@",i, [NSThread currentThread]);
    });
    
    NSLog(@"end==+==");
}

- (void)testBarrier {
    dispatch_queue_t dataQueue = dispatch_queue_create("aabbcc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"read data 1");
    });
    
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 2");
    });

    dispatch_barrier_sync(dataQueue, ^{
        NSLog(@"write data 1");

        [NSThread sleepForTimeInterval:1.f];
    });
    
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"read data 3");
    });
    
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 4");
    });
}

- (void)test3 {
    NSLog(@"XXX-1");

    double delay = 2.0;
    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(t, dispatch_get_main_queue(), ^{
        NSLog(@"XXX-2");
    });
}


- (void)test1 {
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);//并发
    dispatch_queue_t sQueue = dispatch_queue_create("gcd-queue-create-serial", NULL);
    dispatch_queue_t fQueue = dispatch_queue_create("gcd-queue-create-serial", NULL);

    dispatch_queue_t secondQueue = dispatch_queue_create("gcd-queue-create-concurrent", DISPATCH_QUEUE_CONCURRENT);

//    dispatch_set_target_queue(fQueue, globalQueue);
//    dispatch_set_target_queue(sQueue, secondQueue);
    
    dispatch_sync(sQueue, ^{
        NSLog(@"3 - secondQueue");
//        [NSThread sleepForTimeInterval:10.f];

    });
//    dispatch_async(fQueue, ^{
//        NSLog(@"1 - fQueue");
////        [NSThread sleepForTimeInterval:3.f];
//    });
//
//    dispatch_async(secondQueue, ^{
//        [NSThread sleepForTimeInterval:60.f];
//
//        NSLog(@"2 - secondQueue");
//
//    });
    
   
}
- (void)test {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();//串行
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);//并发
    
    NSLog(@"%@-%@", mainQueue, globalQueue);
    
    dispatch_queue_t sQueue = dispatch_queue_create("gcd-queue-create-serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t cQueue = dispatch_queue_create("gcd-queue-create-concurrent", NULL);
    
    NSLog(@"%@-%@", sQueue, cQueue);

    dispatch_sync(sQueue, ^{
        //同步操作
        NSLog(@"同步操作");
        
        dispatch_sync(globalQueue, ^{
            NSLog(@"同步操作1");
        });
    });
    
    dispatch_async(cQueue, ^{
        //异步操作
        NSLog(@"异步操作");
    });
    

    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
