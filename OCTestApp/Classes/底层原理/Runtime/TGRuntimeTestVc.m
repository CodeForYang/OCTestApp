//
//  TGRuntimeTestVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/4/6.
//

#import "TGRuntimeTestVc.h"
#import <objc/message.h>
#import "TGPerson.h"
@interface TGSark(){
NSInteger _instance1;
NSString * _instance2;
}
@property (nonatomic, assign) NSUInteger integer;

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;

@end

@implementation TGSark



+ (void)classMethod1 {
}

- (void)method1 {
     NSLog(@"call method method1");
}

- (void)method2 {
}

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
     NSLog(@"arg1 : %ld, arg2 : %@", arg1, arg2);
}

- (void)speak
{
     unsigned int numberOfIvars = 0;
     Ivar *ivars = class_copyIvarList([self class], &numberOfIvars);
     for(const Ivar *p = ivars; p < ivars+numberOfIvars; p++) {
          Ivar const ivar = *p;
          ptrdiff_t offset = ivar_getOffset(ivar);
          const char *name = ivar_getName(ivar);
          NSLog(@"Sark ivar name = %s, offset = %td", name, offset);
     }
     NSLog(@"my name is %p", &_name);
     NSLog(@"my name is %@", *(&_name));
}
@end

@interface Test : NSObject
@end
@implementation Test
- (instancetype)init
{
     self = [super init];
     if (self) {
          NSLog(@"Test instance = %@", self);
          void *self2 = (__bridge void *)self;
          NSLog(@"Test instance pointer = %p", &self2);
          id cls = [TGSark class];
          NSLog(@"Class instance address = %p", cls);
          void *obj = &cls;
          NSLog(@"Void *obj = %@", obj);
          [(__bridge id)obj speak];
     }
     return self;
}
@end

@interface TGRuntimeTestVc ()
@property (nonatomic, strong) TGPerson *person;

@end


@implementation TGRuntimeTestVc


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemPinkColor];

    self.view.layer.anchorPoint = CGPointMake(0.9, 0);
//    [[Test alloc] init];
//    int numClass;
//    Class *classes = NULL;
//    numClass = objc_getClassList(NULL, 0);
//
//    if (numClass > 0) {
//        classes = malloc(sizeof(Class) * numClass);
//        numClass = objc_getClassList(classes, numClass);
//    }
    
    self.person = [TGPerson new];
    
    
}

- (void)printFondationClassesTest {
    NSLog(@"NSString's framework: %s", class_getImageName(NSString.class));
    
    unsigned int outCount;
    //获取指定库的所有类名
    const char **list = objc_copyClassNamesForImage(class_getImageName(NSRunLoop.class), &outCount);
    for (int i = 0; i < outCount; i++) {
        NSLog(@"class name: %s", list[i]);
    }
    
//    NSTaggedPointerString *str = @"嘻嘻哈哈-";
}


- (void)strcmpTest {
    const char *name1 = "asdf";
    const char *name2 = "asdf2";

    if (strcmp(name1, name2)) {
        printf("奥斯特洛夫斯基");
    }
}


- (void)addBlockDynamiclly {
    IMP imp = imp_implementationWithBlock(^(id obj, NSString *str) {
        NSLog(@"%@ - %@",obj, str);
    });
    class_addMethod(self.class, @selector(testBlock:), imp, "v@:@");
    [self performSelector:@selector(testBlock:) withObject:@"hello ducadi"];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.person performSelector:@selector(method2)];
}


- (void)addClassInstanceDynamic {
    
    //创建类实例
//    class_createInstance(TGSark.class, 0);
    
    /*
     
     OBJC_ARC_UNAVAILABLE
    objc_constructInstance(TGSark.class, void *);
    
    objc_destructInstance(TGSark.class);
     
     */
    
    id aObj = class_createInstance(TGSark.class, sizeof(unsigned));
    id str1 = [aObj init];
    NSLog(@"%@", [str1 class]);
    
    id str2 = [[TGSark alloc] init];
    NSLog(@"%@", [str2 class]);
}


/// 动态添加方法
- (void)addMethodDynamic {
    //    [self performSelector:@selector(testAbcd)];
        //创建一个新类和原类
    //    //如果创建是 root class, 则 superclass 为 Nil,extraBytes 通常为0
    //    objc_allocateClassPair(TGSark.class, "TGSubSark", 0);
    //
    //    //销毁一个类及其相关联的类
    //    //没有初始化过的 || 元类 || 有存在的子类  不能调用这个
    //    objc_disposeClassPair(TGSark.class);
    //
    //    //注册由 objc_allocateClassPair 创建的类
    //    //class_addMethod, class_addIvar,实例变量, 属性之后再调用这个注册,
    //    objc_registerClassPair(TGSark.class);
        
        Class cls = objc_allocateClassPair(TGSark.class, "TGSubSark", 0);
        class_addMethod(cls, @selector(submethod1), (IMP)imp_subMethod1, "v@:");//添加方法
        class_replaceMethod(cls, @selector(method1), (IMP)imp_subMethod1, "v@:");//替换方法
        class_addIvar(cls, "_ivar1", sizeof(NSString *), log2(sizeof(NSString *)), "i");//成员变量

        //属性
        objc_property_attribute_t type = {};
        objc_property_attribute_t ownership = {"C", ""};//copy
        objc_property_attribute_t backingivar = {"V", "_ivar1"};//属性对应的实例变量
        objc_property_attribute_t attrs[] = {type, ownership, backingivar};

        //属性 https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
        class_addProperty(cls, "property2", attrs, 3);//3: 总共添加了三个属性
        objc_registerClassPair(cls);

        id instance = [cls new];
        [instance performSelector:@selector(submethod1)];
        [instance performSelector:@selector(method1)];
}

static void imp_subMethod1(id self, SEL cmd){
    printf("奥斯特洛夫斯基\n");
    
}

- (void)imp_subMethod1 {
    NSLog(@"call method imp_subMethod1\n");
}

- (void)kindofClassTest {
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [(id)[TGSark class] isKindOfClass:[TGSark class]];
    BOOL res4 = [(id)[TGSark class] isMemberOfClass:[TGSark class]];
    NSLog(@"%d %d %d %d", res1, res2, res3, res4);
}




/// 打印属性 & 方法 & 协议 & 成员变量
- (void)printAll {
    TGSark *myClass = [TGSark new];
    Class cls = myClass.class;
    
    //类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"==========================================================");
    
    //父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"==========================================================");
    
    //是否为元类
    NSLog(@"TGSark is %s a metaClass", (class_isMetaClass(cls) ? "" : "not"));
    NSLog(@"==========================================================");
    
    //获取元类
    const char *metaCls = class_getName(objc_getMetaClass(class_getName(cls)));
    NSLog(@"%s's metaClass is %s", class_getName(cls),  metaCls);
    NSLog(@"==========================================================");
    
    //实例大小
    NSLog(@"cls instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"==========================================================");
    
    //成员变量
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar var = ivars[i];
        NSLog(@"instance variable's name: %s at index %d", ivar_getName(var), i);
    }
    free(ivars);
    
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string) {
        NSLog(@"instance variable %s", ivar_getName(string));
    }
    NSLog(@"==========================================================");

    //属性列表
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t p = properties[i];
        NSLog(@"property's name: %s", property_getName(p));
    }
    free(properties);
    
    objc_property_t p = class_getProperty(cls, "array");
    if (p) {
        NSLog(@"property %s", property_getName(p));
    }
    NSLog(@"==========================================================");
    
    //方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", sel_getName(method_getName(method)));
    }
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1) {
        NSLog(@"method %s", sel_getName(method_getName(method1)));
    }
    
    Method clsMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (clsMethod) {
        NSLog(@"method %s", sel_getName(method_getName(clsMethod)));
    }
    
    NSLog(@"MyClass is%@ responds to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @"not");

    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    NSLog(@"==========================================================");
    
    //协议
    Protocol *__unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    
    NSLog(@"TGSark is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @"not", protocol_getName(protocol));
    NSLog(@"==========================================================");
}
@end



