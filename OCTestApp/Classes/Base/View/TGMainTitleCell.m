//
//  TGMainTitleCell.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/9.
//

#import "TGMainTitleCell.h"
@interface TGMainTitleCell()

@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIView *contentBgView;

@end
@implementation TGMainTitleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
    
}

- (void)setup {
    
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-5);

        make.height.equalTo(@64);
    }];
    
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentBgView).offset(11);
        make.top.equalTo(self.contentBgView).offset(8);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentBgView).offset(11);
        make.bottom.equalTo(self.contentBgView).offset(-8);
    }];
}


- (void)setItem:(TGTitleModel *)item {
    _item = item;
    self.mainTitleLabel.text = item.title;
    self.subTitleLabel.text = item.subTitle;

}

- (UILabel *)mainTitleLabel {
    if (_mainTitleLabel) return _mainTitleLabel;
    
    _mainTitleLabel = [UILabel new];
    _mainTitleLabel.textColor = [UIColor blackColor];
    _mainTitleLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_mainTitleLabel];
    return _mainTitleLabel;
}

- (UILabel *)subTitleLabel {
    if (_subTitleLabel) return _subTitleLabel;
    
    _subTitleLabel = [UILabel new];
    _subTitleLabel.textColor = [UIColor blackColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_subTitleLabel];
    return _subTitleLabel;
}

- (UIView *)contentBgView {
    if (_contentBgView) return _contentBgView;
   
    _contentBgView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    _contentBgView.backgroundColor = [[UIColor systemPinkColor] colorWithAlphaComponent:0.4];
    [self.contentView insertSubview:_contentBgView atIndex:0];
    _contentBgView.layer.cornerRadius = 8;
    _contentBgView.clipsToBounds = TRUE;
    return _contentBgView;

}
@end
