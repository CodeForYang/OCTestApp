//
//  ZoobieVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/10.
//

#import "ZoobieVc.h"
#import "MyObject.h"



@interface ZoobieVc ()

@property (nonatomic, unsafe_unretained) MyObject *object;
@end

@implementation ZoobieVc

- (void)viewDidLoad {
    [super viewDidLoad];

    MyObject *obj = [[MyObject alloc] init];
    self.object = obj;
    
    self.object.edwardTT = @"Hello world";
    void *p = (__bridge void *)(self.object);
    NSLog(@"%p, %@",self.object, self.object.edwardTT);
    NSLog(@"%p, %@",p, [(__bridge MyObject *)p edwardTT]);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%p",self->_object);
    NSLog(@"%@", self.object.edwardTT);

}


@end



