//
//  MixtureCell.m
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "MixtureCell.h"
#import "MixtureCollecionViewCell.h"
#import "Masonry.h"

@implementation UIColor (RandomColor)
+(UIColor *) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end

@interface MixtureCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UICollectionView *collection;
@property(nonatomic, strong) NSMutableArray <NSString *>*datas;

@end

@implementation MixtureCell

+ (instancetype)configWithTableView:(UITableView *)tableView {
    MixtureCell * cell = [tableView dequeueReusableCellWithIdentifier:kMixtureCellID];
    if (!cell) {
        cell = [[MixtureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMixtureCellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setContentContraints];
    }
    return self;
}

- (void)setTitles:(NSMutableArray<NSString *> *)titles {
    _titles = titles;
    self.datas = titles;
    
#warning 主动计算collectionView的高度
    NSUInteger hang = self.datas.count / 4 + 1;
    CGRect f = self.collection.frame;
    f.size.height = hang * 100 + (hang - 1) * 10 ;
    self.collection.frame = f;
    
    [self.collection reloadData];
}

- (void)setContentContraints {
    self.backView = [[UIView alloc]init];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.collection];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.collection.mas_bottom);
        make.bottom.equalTo(@0).priority(750);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MixtureCollecionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMixtureCollecionViewCellID forIndexPath:indexPath];
    cell.label.text = self.datas[indexPath.row];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}


- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(100, 100);
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 200) collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerClass:[MixtureCollecionViewCell class] forCellWithReuseIdentifier:kMixtureCollecionViewCellID];
        _collection.backgroundColor = [UIColor randomColor];
        _collection.scrollEnabled = NO;
    }
    return _collection;
}

- (NSMutableArray<NSString *> *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray alloc]init];
    }
    return _datas;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
