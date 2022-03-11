//
//  YHMallocScrbble.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/11.
//

#import "YHMallocScrbble.h"
#include "fishhook.h"
#include <malloc/malloc.h>

void * (*ori_malloc)(size_t __size);
void (*ori_free)(void *p);
@implementation YHMallocScrbble

@end
