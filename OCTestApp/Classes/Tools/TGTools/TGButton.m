//
//  TGButton.m
//  TGICardKit
//
//  Created by jf on 2019/11/21.
//

#import "TGButton.h"
//#import "TGToolsKit.h"
@interface TGButton()
@property (nonatomic, strong) UIView *shadowView;
@end


@implementation TGButton


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
        if(hitView == self.shadowView){
            return nil;
        }
        return hitView;
}

-(void)tg_clipWithCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = true;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat space = self.spaceBetweenTitleAndImage;
    
    CGFloat titleW = CGRectGetWidth(self.titleLabel.bounds);
    CGFloat titleH = CGRectGetHeight(self.titleLabel.bounds);
    
    CGFloat imageW = CGRectGetWidth(self.imageView.bounds);
    CGFloat imageH = CGRectGetHeight(self.imageView.bounds);
    
    CGFloat btnCenterX = CGRectGetWidth(self.bounds)/2;
    CGFloat imageCenterX = btnCenterX - titleW/2;
    CGFloat titleCenterX = btnCenterX + imageW/2;
    
    
    switch (self.imageAlignment) {
        case TGButtonImageAlignmentTop: {
            self.titleEdgeInsets = UIEdgeInsetsMake(imageH/2+ space/2, -(titleCenterX-btnCenterX), -(imageH/2 + space/2), titleCenterX-btnCenterX);
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleH/2 + space/2), btnCenterX-imageCenterX, titleH/2+ space/2, -(btnCenterX-imageCenterX));
        }
            break;
        case TGButtonImageAlignmentLeft: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0,  -space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space);
        }
            break;
        case TGButtonImageAlignmentBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageH/2+ space/2), -(titleCenterX-btnCenterX), imageH/2 + space/2, titleCenterX-btnCenterX);
            self.imageEdgeInsets = UIEdgeInsetsMake(titleH/2 + space/2, btnCenterX-imageCenterX,-(titleH/2+ space/2), -(btnCenterX-imageCenterX));
        }
            break;
        case TGButtonImageAlignmentRight: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageW + space/2), 0, imageW + space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW+space/2, 0, -(titleW+space/2));
        }
            break;
        default:
            break;
    }
    
}


+ (instancetype)navigationSelectionButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    TGButton *titleBtn = [[TGButton alloc] init];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor systemGrayColor] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"tg_workbench_navi_arrow"] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    titleBtn.imageAlignment = TGButtonImageAlignmentRight;
    if (target && action) {
        [titleBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return titleBtn;
}


@end
