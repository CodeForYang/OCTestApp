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

@interface TGSlideSwitchHeaderView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
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
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = ItemMargin;
    [layout registerClass:TGSlideSegementCell.class forDecorationViewOfKind:@"TGSlideSegementCell"];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self addSubview:self.collectionView];
    
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TGSlideSegementCell *cell = (TGSlideSegementCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"TGSlideSegementCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:ItemFont];
    cell.textLabel.textColor = self.ItemNormalColor;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}



- (CGSize)textSizeWith:(NSIndexPath *)indexPath {
    
    NSString *title = self.titles[indexPath.row];
    
    NSStringDrawingOptions op = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *paragra = [[NSMutableParagraphStyle alloc] init];
    paragra.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSDictionary *attr = @{NSParagraphStyleAttributeName : paragra, NSFontAttributeName : [UIFont systemFontOfSize:ItemFont]};
    
    return [title boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) options:op attributes:attr context:nil].size;
}

@end
