//
//  TGDispatchGroupVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/23.
//

#import "TGDispatchGroupVc.h"

@interface TGDispatchGroupVc ()

@end

@implementation TGDispatchGroupVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        [self test];
    });
    
}

- (void)test {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_enter(group);
    
    NSLog(@"加入");
    NSLog(@"加入");

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"即将离开 %@- 1", [NSThread currentThread]);
        dispatch_group_leave(group);
        NSLog(@"已经离开 %@- 1", [NSThread currentThread]);
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"即将离开 %@- 2", [NSThread currentThread]);
        dispatch_group_leave(group);
        NSLog(@"已经离开 %@- 2",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"都完成了");
    });
    
    NSLog(@"开始等待 %@", [NSThread currentThread]);
    
    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)));
    
    NSLog(@"等待结束 %@", [NSThread currentThread]);
    
/* 结论
 dispatch_group_enter 和 dispatch_group_leave必须成对出现;
 如果 enter 次数多于 leave 次数, notify 不会执行,
 如果 enter 次数少于 leave 次数, 程序会崩溃(EXC_BAD_INSTRUCTION)
 enter 和 leave 的本质就是在 group 中追加任务
 *  "已经离开 %@- 2" 和 "等待结束" 在不同线程执行, 所以打印顺序在等待时间相等情况下不确定
 *  延时任务都是在主线程执行的
 */
}

@end
