//
//  AutoCell.m
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "AutoCell.h"
#import "Masonry.h"

@implementation UIColor (RandomColor)
+(UIColor *) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end

@interface AutoCell ()

@property(nonatomic, weak) UILabel *contentLabel;
@property(nonatomic, weak) UILabel *phoneLabel;
@property(nonatomic, weak) UILabel *timeLabel;
@property(nonatomic, weak) UILabel *encourageLabel;
@property(nonatomic, weak) UILabel *talkLabel;

@property(nonatomic, strong) NSMutableArray <UIImageView *>*ivs;

@end

@implementation AutoCell

+ (instancetype)configWithTableView:(UITableView *)tableView {
    AutoCell * cell = [tableView dequeueReusableCellWithIdentifier:kAutoCellID];
    if (!cell) {
        cell = [[AutoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAutoCellID];
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

#pragma mark - 第一个版本赋值 无图片
//- (void)setModel:(AutoModel *)model{
//    _model = model;
//    self.contentLabel.text = model.content;
//    self.phoneLabel.text = model.phone;
//    self.timeLabel.text = model.time;
//    self.encourageLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.encourage];
//    self.talkLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.talk];
//}
#pragma mark - 第二个版本赋值 有图片
- (void)setModel:(AutoModel *)model {
    _model = model;
    self.contentLabel.text = model.content;
    self.phoneLabel.text = model.phone;
    self.timeLabel.text = model.time;
    self.encourageLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.encourage];
    self.talkLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.talk];
    
#warning 解决iv在上下滑动时一直add的问题 开始 >>>>>>>
    if (self.ivs.count > 0) {
        for (UIImageView * iv in self.ivs) {
            [iv removeFromSuperview];
        }
        [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
            make.left.equalTo(@0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5).priority(750);
        }];
    }
#warning 解决iv在上下滑动时一直add的问题 结束 <<<<<<<
    
    if (model.images.count > 0) {
        // 图片固定宽高
        CGFloat imageWH = ((self.bounds.size.width - 20) - 10 * model.images.count ) /  model.images.count;
        NSLog(@"image wh = %f",imageWH);
        
        UIImageView * tIV = nil;
        for (int i = 0; i<model.images.count; i++) {
            AutoImageModel * imageModel = model.images[i];
            UIImage * image = [UIImage imageNamed:imageModel.defaultImageName];
            UIImageView * iv = [[UIImageView alloc]init];
            iv.image = image;
            [self.contentView addSubview:iv];
            
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
                make.width.height.mas_equalTo(imageWH);
                make.left.mas_equalTo(10 + imageWH * i + 10 * i);
            }];
            //解决iv在上下滑动时一直add的问题
            [self.ivs addObject:iv];
            
            tIV = iv;
        }
        
        // 更新手机的约束 无效
//        [self.phoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(tIV.mas_bottom).offset(10);
//        }];
        
        // 重做手机的顶部约束
        [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tIV.mas_bottom).offset(10);
            make.left.equalTo(@0);
#warning 关键代码
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5).priority(750);
        }];
    }
}

#pragma mark - 第一个版本约束
- (void)setContentContraints {
    self.phoneLabel.backgroundColor = [UIColor redColor];
    self.timeLabel.backgroundColor = [UIColor blueColor];
    
    // 以下Label全都是自适应宽高
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0).offset(5);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
        make.left.equalTo(@0);
#warning 关键代码  尝试注释一下运行看效果 -> 重叠
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5).priority(750);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.phoneLabel);
#warning 解决phone跟time挤到一起的问题,一行代码搞定
        make.left.greaterThanOrEqualTo(self.phoneLabel.mas_right).offset(10);
    }];
    
    [self.talkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0).offset(-10);
        make.centerY.equalTo(self.phoneLabel);
    }];
    
    [self.encourageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneLabel);
        make.right.equalTo(self.talkLabel.mas_left).offset(-10);
    }];
}

- (NSMutableArray<UIImageView *> *)ivs {
    if (!_ivs) {
        _ivs = [[NSMutableArray alloc]init];
    }
    return _ivs;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [self createLabel];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [self createLabel];
    }
    return _phoneLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [self createLabel];
    }
    return _timeLabel;
}

- (UILabel *)encourageLabel {
    if (!_encourageLabel) {
        _encourageLabel = [self createLabel];
    }
    return _encourageLabel;
}

- (UILabel *)talkLabel {
    if (!_talkLabel) {
        _talkLabel = [self createLabel];
    }
    return _talkLabel;
}

- (UILabel * )createLabel{
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor randomColor];
    [self.contentView addSubview:label];
    return label;
}

- (UIImageView *)createIV{
    UIImageView * iv = [[UIImageView alloc]init];
    [self.contentView addSubview:iv];
    return iv;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
