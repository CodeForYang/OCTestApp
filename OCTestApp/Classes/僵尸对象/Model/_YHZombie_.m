//
//  _YHZombie_.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/10.
//

#import "_YHZombie_.h"

@implementation _YHZombie_


- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%p-[%@ %@]:%@",
          self,
          [NSStringFromClass(self.class) componentsSeparatedByString:@"_YHZombie_"].lastObject,
          NSStringFromSelector(aSelector),
          @"向已经释放的对象发送了消息"
          );
    
    abort();//结束当前线程
}

@end
