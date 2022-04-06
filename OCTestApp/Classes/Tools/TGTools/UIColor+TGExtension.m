//
//  UIColor+TGExtension.m
//  TGToolsKit
//
//  Created by jf on 2019/8/20.
//

#import "UIColor+TGExtension.h"
#import "UIColor+Hex.h"

@implementation UIColor (TGExtension)
+ (instancetype)tg_mainThemeColor {
    return UIColorFromRGB(0x0088FF);
}

+ (instancetype)tg_disableBlueColor {
    return UIColorFromRGB(0x7ACEFF);
}

+ (instancetype)tg_LightLightBlueColor {
    return UIColorFromRGB(0xEBF6FF);
}

+ (instancetype)tg_lightBlueColor {
    return UIColorFromRGB(0x00BDFF);
}

+ (instancetype)tg_selectedBlueColor{
    return UIColorFromRGB(0xE6F3FF);
}

/// 0x007AE6 高亮或者选中蓝色
+ (instancetype)tg_highLightBlueColor {
    return UIColorFromRGB(0x007AE6);
}

+ (instancetype)tg_backgroundLightGrayColor {
    return UIColorFromRGB(0xF8F9FC);
}

+ (instancetype)tg_lineGrayColor {
    return UIColorFromRGB(0xE5E5E5);
}

+ (instancetype)tg_navigationLineGrayColor {
    return UIColorFromRGB(0xCCCCCC);
}

+ (instancetype)tg_navigationFontDarkGrayColor {
    return UIColorFromRGB(0x333333);
}

+ (instancetype)tg_fontRedColor {
    return UIColorFromRGB(0xFF4C4C);
}


+ (instancetype)tg_fontGreenColor {
    return UIColorFromRGB(0x52C41A);
}

+ (instancetype)tg_fontOrangeColor {
    return UIColorFromRGB(0xEE9E00);
}


+ (instancetype)tg_fontDarkDarkDarkGrayColor {
    return UIColorFromRGB(0x262626);
}

+ (instancetype)tg_fontDarkDarkGrayColor {
    return UIColorFromRGB(0x4C4C4C);
}

+ (instancetype)tg_fontDarkGrayColor {
    return UIColorFromRGB(0x8C8C8C);
}

+ (instancetype)tg_fontLightGrayColor {
    return UIColorFromRGB(0xBFBFBF);
}

+ (instancetype)tg_fontLightLightGrayColor {
    return UIColorFromRGB(0xE8E8E8);
}

+ (instancetype)tg_fontLightLightLightGrayColor {
    return UIColorFromRGB(0xF2F2F2);
}

+ (instancetype)tg_darkRedColor {
    return UIColorFromRGB(0xF5222D);
}

+ (instancetype)tg_alertYellowColor {
    return UIColorFromRGB(0xF8C604);
}

+ (instancetype)tg_fontColor_40 {
    return UIColorFromRGB(0x404040);
}

+ (instancetype)tg_fontColor_91 {
    return UIColorFromRGB(0x919191);
}

+ (instancetype)tg_fontColor_19 {
    return UIColorFromRGB(0x191919);
}

/// 中性意味强调色 0xFAAD14 黄色
+ (instancetype)tg_yellowColor {
    return UIColorFromRGB(0xFAAD14);
}

/// 中性意味强调色 0xFF3F3F 红色
+ (instancetype)tg_redColor {
    return UIColorFromRGB(0xFF3F3F);
}

/// 通知角标颜色 0xF5222D 红色
+ (instancetype)tg_noteRedColor {
    return UIColorFromRGB(0xF5222D);
}

/// 成功色 0x9ED305 绿色
+ (instancetype)tg_successGreenColor {
    return UIColorFromRGB(0x9ED305);
}

/// 成功色 0x8AE438 绿色(按钮浅变色用到)
+ (instancetype)tg_lightLightGreenColor {
    return UIColorFromRGB(0x8AE438);
}
/// 成功色 0x52C41A 绿色(按钮浅变色用到)
+ (instancetype)tg_lightGreenColor {
    return UIColorFromRGB(0x52C41A);
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    UIColor * nameForColor = [UIColor colorNameToUIColor:cString];
    if (nameForColor != nil) {
        return nameForColor;
    }
    
    if ([cString length] < 3) return [UIColor blackColor];
    if ([cString hasPrefix:@"0x"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if (![UIColor valideColorStrFormat:cString]) {
        return [UIColor blackColor];
    }
    if ([cString length] == 3 || [cString length] == 4) {
        NSArray * colorSplits = [cString componentsSeparatedByString:@""];
        if(colorSplits.count == 3 || colorSplits.count == 4) {
            cString = @"";
            for (NSString * item in colorSplits) {
                cString  = [cString stringByAppendingFormat:@"%@%@", item, item];
            }
        }
    }
    if ([cString length] == 6) {
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    }
    else if ([cString length] == 8) {
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        range.location = 6;
        NSString *aString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int a, r, g, b;
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:((float) a / 255.0f)];
    }
    else {
        return [UIColor blackColor];
    }
}

/** 通过颜色名称读取Color */
+ (UIColor *)colorNameToUIColor:(NSString *)name {
    if (name == nil || name.length == 0){
        return nil;
    }
    name = [name lowercaseString];
    NSDictionary * color_dict = @{@"transparent": [UIColor colorWithRed:0 green:0 blue:0 alpha:0],
                                  @"black": [UIColor blackColor],
                                  @"white": [UIColor whiteColor],
                                  @"gray": [UIColor grayColor],
                                  @"green": [UIColor greenColor],
                                  @"blue": [UIColor blueColor],
                                  @"cyan": [UIColor cyanColor],
                                  @"yellow": [UIColor yellowColor],
                                  @"magenta": [UIColor magentaColor],
                                  @"orange": [UIColor orangeColor],
                                  @"purple": [UIColor purpleColor],
                                  @"brown": [UIColor brownColor]
                                  };
    
    
    if ([color_dict.allKeys containsObject:name]) {
        return color_dict[name];
    }
    return  nil;
}

/** 颜色值校验 */
+ (BOOL)valideColorStrFormat:(NSString *)source {
    if(source == nil || source.length == 0) {
        return NO;
    }
    if(source.length != 3 && source.length != 6 && source.length != 8){
        return NO;
    }
    NSError *error;
    NSString *strNumberRegExp = @"^(([\\da-fA-F]{3}){1,2}|([\\da-fA-F]{8}))$";
    NSRegularExpression * regExp = [NSRegularExpression regularExpressionWithPattern:strNumberRegExp options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matchResults  = [regExp matchesInString:source options:NSMatchingReportCompletion range:NSMakeRange(0, source.length)];
    if (matchResults != nil && matchResults.count == 1) {
        NSRange range = [matchResults[0] range];
        return [source isEqualToString:[source substringWithRange:range]];
    }
    return NO;
}

/// 默认主色值
/// @param alpha 透明度
+ (UIColor *)tg_mainThemeColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithHexString:@"#0088FF" alpha:alpha];
}

/// 默认字体色值
/// @param alpha 字体透明度
+ (UIColor *)tg_defaultLabelColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithHexString:@"#111F2C" alpha:alpha];
}

/// 新的全局背景色，F7F8FC
+ (UIColor *)tg_globalBackgroundGray {
    return [UIColor colorWithHexString:@"#F7F8FC" alpha:1];
}

/// 新的控件背景灰色，模块等背景色(搜索控件、搜索标签)，F2F4F9
+ (UIColor *)tg_controlBackgroundGray {
    return [UIColor colorWithHexString:@"#F2F4F9" alpha:1];
}

// 弹窗遮罩背景色 1F2533 60%
+ (UIColor *)tg_maskBgColor {
    return [UIColor colorWithHexString:@"#1F2533" alpha:0.6];
}

/// 白色
+ (UIColor *)tg_whiteColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithWhite:1 alpha:alpha];
}

#pragma mark - 随机颜色
/// 随机颜色
+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
}


/// 头像随机颜色
+ (UIColor *)avatarRandomColor:(NSString *)str {
    NSArray *colorStrings = [self avatarRandomColorStrings];
    return [UIColor colorWithHexString:colorStrings[str.hash % colorStrings.count]];
}

+ (NSArray <NSString *>*)avatarRandomColorStrings {
    return @[@"0088FF", @"29BFFF", @"18D0D0"];
}

+ (UIColor *)customerAvatarRandomColor:(NSString *)str {
    NSArray *colorStrings = [self customerAvatarRandomColorStrings];
    return [UIColor colorWithHexString:colorStrings[str.hash % colorStrings.count]];
}

+ (NSArray <NSString *>*)customerAvatarRandomColorStrings {
    return [self avatarRandomColorStrings];
}

@end


