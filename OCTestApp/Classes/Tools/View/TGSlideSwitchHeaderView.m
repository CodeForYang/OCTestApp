//
//  TGSlideSwitchHeaderView.m
//  OCTestApp
//
//  Created by 杨佩 on 2022/3/12.
//

#import "TGSlideSwitchHeaderView.h"
#import "TGSlideSegementCell.h"

static const CGFloat ItemMargin = 10.0f;
static const CGFloat ItemFont = 17.0f;
static const CGFloat ItemMaxScale = 1.1f;

@interface TGSlideSwitchHeaderView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *shadow;

@property (nonatomic, strong) UIView *bottomLine;


@end

@implementation TGSlideSwitchHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = ItemMargin;
//    [layout registerClass:TGSlideSegementCell.class forDecorationViewOfKind:@"TGSlideSegementCell"];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, ItemMargin, 0, ItemMargin);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:TGSlideSegementCell.class forCellWithReuseIdentifier:@"TGSlideSegementCell"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self addSubview:self.collectionView];
    
    self.shadow = [UIView new];
    [self addSubview:self.shadow];
    
    self.bottomLine = [UIView new];
    [self addSubview:self.bottomLine];
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TGSlideSegementCell *cell = (TGSlideSegementCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"TGSlideSegementCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:ItemFont];
    
    CGFloat scale = indexPath.row == _selectedIndex ? ItemMaxScale : 1;
    cell.transform = CGAffineTransformMakeScale(scale, scale);
    cell.textLabel.textColor = indexPath.row == _selectedIndex ? self.ItemSelectedColor : self.ItemNormalColor;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndex = indexPath.row;
   
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self textSizeWith:indexPath], _collectionView.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (_customMargin) {
        return _customMargin;
    }
    
    return ItemMargin;
}


- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    
    CGFloat rectX = [self shadowRectOfIndex:_selectedIndex].origin.x;
    
    if (rectX <= 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _shadow.frame = [self shadowRectOfIndex:_selectedIndex];
        });
    } else {
        _shadow.frame = [self shadowRectOfIndex:_selectedIndex];

    }
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
   
    [_collectionView reloadData];
    
    if ([_delegate respondsToSelector:@selector(slideSegmentDidSelectIndex:)]) {
        [_delegate slideSegmentDidSelectIndex:_selectedIndex];
    }
    
}

- (CGRect)shadowRectOfIndex:(NSInteger)index {
    return CGRectMake([_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]].frame.origin.x, self.bounds.size.height - 2, [self textSizeWith:[NSIndexPath indexPathForRow:index inSection:0]], 2);
}

- (void)setCustomMargin:(CGFloat)customMargin {
    _customMargin = customMargin;
    
    [_collectionView reloadData];
}

- (void)setAddButton:(UIButton *)addButton {
    _addButton = addButton;
    
    [self addSubview:addButton];
}


- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    if (_ignoreAnimation) return;
    
    [self updateShadowPosition:progress];
    
    [self updateItem:progress];
    
}

- (void)reloadData {
    [self.collectionView reloadData];
}
- (void)updateShadowPosition:(CGFloat)progress {
    
    NSInteger nextIndex = progress > 1 ? _selectedIndex + 1 : _selectedIndex - 1;
    if (nextIndex < 0 || nextIndex == _titles.count) return;
    CGRect currentRect = [self shadowRectOfIndex:_selectedIndex];
    CGRect nextRect = [self shadowRectOfIndex:nextIndex];
    
    if (CGRectGetMinX(currentRect) <= 0 || CGRectGetMinX(nextRect) <= 0) return;
    
    progress = progress > 1 ? progress - 1 : 1 - progress;
    CGFloat width = currentRect.size.width - progress * (nextRect.size.width - currentRect.size.width);
    CGRect bounds = _shadow.bounds;
    bounds.size.width = width;
    _shadow.bounds = bounds;
    
    CGFloat distance = CGRectGetMinX(nextRect) - CGRectGetMinX(currentRect);
    _shadow.center = CGPointMake(CGRectGetMinX(currentRect) + progress * distance, _shadow.center.y);
    
}


- (void)updateItem:(CGFloat)progress {
    NSInteger nextIndex = progress > 1 ? _selectedIndex + 1 : _selectedIndex - 1;
    if (nextIndex < 0 || nextIndex == _titles.count) return;
    
    TGSlideSegementCell *curItem = (TGSlideSegementCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    TGSlideSegementCell *nextItem = (TGSlideSegementCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:nextIndex inSection:0]];
    
    progress = progress > 1 ? progress - 1 : 1 - progress;
    
    //更新颜色
    curItem.textLabel.textColor = [self transfromFromColor:_ItemSelectedColor toColor:_ItemNormalColor progress:progress];
    nextItem.textLabel.textColor = [self transfromFromColor:_ItemNormalColor toColor:_ItemSelectedColor progress:progress];

    //更新放大
    CGFloat curScale = ItemMaxScale - (ItemMaxScale - 1) * progress;
    CGFloat nextScale = 1 - (1 - ItemMaxScale) * progress;
    curItem.transform = CGAffineTransformMakeScale(curScale, curScale);
    nextItem.transform = CGAffineTransformMakeScale(nextScale, nextScale);

}

- (UIColor *)transfromFromColor:(UIColor *)f toColor:(UIColor *)t progress:(CGFloat)p {
    
    if (!f || !t) return [UIColor blackColor];
    
    p = p >= 1 ? 1 : p;
    p = p <= 0 ? 0 : p;
    
    const CGFloat * fComponets = CGColorGetComponents(f.CGColor);
    const CGFloat * tComponets = CGColorGetComponents(t.CGColor);
    
    size_t fColorNumber = CGColorGetNumberOfComponents(f.CGColor);
    size_t tColorNumber = CGColorGetNumberOfComponents(t.CGColor);
    
    if (fColorNumber == 2) {
        CGFloat white = fComponets[0];
        f = [UIColor colorWithRed:white green:white blue:white alpha:1];
        fComponets = CGColorGetComponents(f.CGColor);
    }
    
    if (tColorNumber == 2) {
        CGFloat white = tComponets[0];
        t = [UIColor colorWithRed:white green:white blue:white alpha:1];
        tComponets = CGColorGetComponents(t.CGColor);
    }
    
    CGFloat r = fComponets[0] * (1 - p) + tComponets[0] * p;
    CGFloat g = fComponets[1] * (1 - p) + tComponets[1] * p;
    CGFloat b = fComponets[2] * (1 - p) + tComponets[2] * p;

    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (CGFloat)textSizeWith:(NSIndexPath *)indexPath {
    
    NSString *title = self.titles[indexPath.row];
    
    NSStringDrawingOptions op = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *paragra = [[NSMutableParagraphStyle alloc] init];
    paragra.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSDictionary *attr = @{NSParagraphStyleAttributeName : paragra, NSFontAttributeName : [UIFont systemFontOfSize:ItemFont]};
    
    return [title boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) options:op attributes:attr context:nil].size.width;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (_addButton) {
        CGFloat buttonW = self.frame.size.height;//宽高相等
        CGFloat collectionW = self.bounds.size.width - buttonW;
        _addButton.frame = CGRectMake(collectionW, 0, collectionW, buttonW);
        _collectionView.frame = CGRectMake(0, 0, collectionW, self.bounds.size.height);
    } else {
        _collectionView.frame = self.bounds;
    }
    
    [_collectionView performBatchUpdates:nil completion:^(BOOL finished) {
        if (_collectionView.contentSize.width < _collectionView.bounds.size.width) {
            CGFloat insetX = (_collectionView.bounds.size.width - _collectionView.contentSize.width) / 2.0f;
            _collectionView.contentInset = UIEdgeInsetsMake(0, insetX, 0, insetX);
        }
    }];
    
    _shadow.backgroundColor = _ItemSelectedColor;
    self.selectedIndex = _selectedIndex;
    _shadow.hidden = _hideShadow;
    _bottomLine.frame = CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
    _bottomLine.hidden = _hideBottonLine;
}
@end
