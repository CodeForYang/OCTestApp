//
//  TGCharSetVc.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/18.
//

#import "TGCharSetVc.h"

@interface TGCharSetVc ()

@end

@implementation TGCharSetVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *str = @"7sjf78sf990s";
//
//    NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//    NSLog(@"set ---%@", [[str componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""]);
    
    NSString *bananas = @"123.321abc137d efg/hij kl";
    NSString *separatorString = @"fg";
    BOOL result;
    NSString *container;

    NSScanner *aScanner = [NSScanner scannerWithString:bananas];
    result = [aScanner scanUpToString:separatorString intoString:&container];
    
    NSLog(@"扫描仪所在的位置: %lu - %@", aScanner.scanLocation, container);
    
    
    
}



@end
