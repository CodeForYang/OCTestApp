//
//  UIColor+TGExtension.h
//  TGToolsKit
//
//  Created by jf on 2019/8/20.
//

#import <UIKit/UIKit.h>

/** RGB color macro */
#define UIColorFromRGB(rgbValue)  \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]
/** color macro with alpha */
#define UIColorFromRGBWithAlpha(rgbValue,a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:a]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TGExtension)

#pragma mark - 主题色 蓝色 由深到浅
+ (instancetype)tg_mainThemeColor;                     /**< 0x0088FF 主题色 蓝 */
+ (instancetype)tg_disableBlueColor;                   /**< 0x7ACEFF 主按钮不可用 蓝 */
+ (instancetype)tg_LightLightBlueColor;                /**< 0xEBF6FF 默认点击选中色 特别浅的蓝色 */
+ (instancetype)tg_lightBlueColor;                     /**< 0x00BDFF 浅蓝色 浅变色用到的浅蓝色 */
+ (instancetype)tg_selectedBlueColor;                /**< 0xE6F3FF 默认点击选中浅蓝色 */
/// 0x007AE6 高亮或者选中蓝色
+ (instancetype)tg_highLightBlueColor;

#pragma mark - 各种灰色
+ (instancetype)tg_backgroundLightGrayColor;           /**< 0xF8F9FC 底色特别浅的灰色 */
+ (instancetype)tg_lineGrayColor;                      /**< 0xE5E5E5 内容分割线灰色 */
+ (instancetype)tg_navigationLineGrayColor;            /**< 0xCCCCCC 绝对分割线(比如导航栏分割线) */
+ (instancetype)tg_navigationFontDarkGrayColor;        /**< 0x333333 导航栏标题深灰色 */

#pragma mark - 所有字色 由深到浅
+ (instancetype)tg_fontRedColor;                       /**< 0xff4c4c 文字高亮红色 */
+ (instancetype)tg_fontGreenColor;                     /**< 0x52c41a 文字绿色 */
+ (instancetype)tg_fontOrangeColor;                    /**< 0xee9e00 文字橙色 */


+ (instancetype)tg_fontDarkDarkDarkGrayColor;          /**< 0x262626 文字深灰色 */
+ (instancetype)tg_fontDarkDarkGrayColor;              /**< 0x4C4C4C 文字深灰色 */
+ (instancetype)tg_fontDarkGrayColor;                  /**< 0x8C8C8C 文字深灰色 */
+ (instancetype)tg_fontLightGrayColor;                 /**< 0xBFBFBF 文字浅灰色 */
+ (instancetype)tg_fontLightLightGrayColor;            /**< 0xE5E5E5 文字浅灰色 */
+ (instancetype)tg_fontLightLightLightGrayColor;       /**< 0xF2F2F2 文字浅灰色 */

+ (instancetype)tg_fontColor_40;
+ (instancetype)tg_fontColor_91;
+ (instancetype)tg_fontColor_19;

#pragma mark - 黄色
+ (instancetype)tg_alertYellowColor;/// 提醒 0xF8C604
+ (instancetype)tg_yellowColor;/// 中性意味强调色 0xFAAD14 黄色

#pragma mark - 红色
+ (instancetype)tg_darkRedColor;                       /**< 0xF5222D 通知/提醒圆点 红色 */
+ (instancetype)tg_redColor;/// 中性意味强调色 0xFF3F3F 红色
+ (instancetype)tg_noteRedColor;/// 通知角标颜色 0xF5222D 红色

#pragma mark - 绿色
+ (instancetype)tg_successGreenColor;/// 成功色 0x9ED305 绿色
+ (instancetype)tg_lightLightGreenColor;/// 成功色 0x8AE438 绿色(按钮浅变色用到)
+ (instancetype)tg_lightGreenColor;/// 成功色 0x52C41A 绿色(按钮浅变色用到)

#pragma mark - 其他

/** 将 hex string 解析为颜色 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/// 默认主色值(蓝色)
/// @param alpha 透明度
+ (UIColor *)tg_mainThemeColorWithAlpha:(CGFloat)alpha;

/// 默认字体色值
/// @param alpha 字体透明度
+ (UIColor *)tg_defaultLabelColorWithAlpha:(CGFloat)alpha;

/// 新的全局背景色，F7F8FC
+ (UIColor *)tg_globalBackgroundGray;

/// 新的控件背景灰色，模块等背景色(搜索控件、搜索标签)，F2F4F9
+ (UIColor *)tg_controlBackgroundGray;

// 弹窗遮罩背景色 1F2533 60%
+ (UIColor *)tg_maskBgColor;

/// 白色
+ (UIColor *)tg_whiteColorWithAlpha:(CGFloat)alpha;

NS_INLINE UIColor * tg_fontColor(CGFloat alpha) { return [UIColor tg_defaultLabelColorWithAlpha: alpha]; }


/**< 随机颜色 */
+ (UIColor *)randomColor;
/// 头像随机颜色
+ (UIColor *)avatarRandomColor:(NSString *)str;
+ (UIColor *)customerAvatarRandomColor:(NSString *)str;

@end

NS_ASSUME_NONNULL_END


