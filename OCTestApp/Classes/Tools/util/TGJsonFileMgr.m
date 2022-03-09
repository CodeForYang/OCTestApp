//
//  TGJsonFileMgr.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "TGJsonFileMgr.h"

@implementation TGJsonFileMgr

- (nullable id)fileGet {
    
    if (!self.fileName || self.fileName.length < 1) {
        TGLog(@"fileName: %@", _fileName);
        return nil;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.fileName ofType:@"json"];
    
    NSData *d = [NSData dataWithContentsOfFile:path];
    id obj = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableContainers error:nil];
    sleep(1);
    
    return obj;
}

@end
