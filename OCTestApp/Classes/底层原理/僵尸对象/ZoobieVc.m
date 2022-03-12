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


typedef struct {
    NSString *edwar;
} MyStruct;
@implementation ZoobieVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
//    MyObject *obj = [[MyObject alloc] init];
//    self.object = obj;
//
//    self.object.edwardTT = @"Hello world";
//    void *p = (__bridge void *)(self.object);
//    NSLog(@"%p, %@",self.object, self.object.edwardTT);
//    NSLog(@"%p, %@",p, [(__bridge MyObject *)p edwardTT]);
    
//    MyStruct *p = malloc(sizeof(MyStruct));
//    printf("嘻嘻嘻哈哈 - %p - %x\n", p, *((int *)p));
//    NSLog(@"%@", p->edwar);
//    p->edwar = @"Edward";
//    free(p);
//
//    NSLog(@"%@",p->edwar);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%p",self->_object);
//    NSLog(@"%@", self.object.edwardTT);
    
    MyStruct *p = malloc(sizeof(MyStruct));
    printf("嘻嘻嘻哈哈 - %p - %x\n", p, *((int *)p));
    NSLog(@"%@", p->edwar);
    p->edwar = @"Edward";
    free(p);

}


@end



