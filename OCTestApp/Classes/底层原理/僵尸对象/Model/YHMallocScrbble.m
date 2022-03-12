//
//  YHMallocScrbble.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/11.
//

#import "YHMallocScrbble.h"
//#include "fishhook.h"
#include <malloc/malloc.h>

void * (*ori_malloc)(size_t __size);
void (*ori_free)(void *p);

void *_YHMalloc_(size_t __size) {
    void *p = ori_malloc(__size);
    memset(p, 0xAA, __size);
    return p;
}

void _YHFree_(void *p) {
    size_t size = malloc_size(p);
    memset(p, 0x55, size);
    ori_free(p);
}

@implementation YHMallocScrbble

+(void)load {
//    rebind_symbols((struct rebinding[2]){
//        {"malloc", _YHMalloc_, (void *)&ori_malloc},
//        {"free", _YHFree_, (void *)&ori_free}
//    }, 2);
}

@end
