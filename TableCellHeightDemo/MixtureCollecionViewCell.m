//
//  MixtureCollecionViewCell.m
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "MixtureCollecionViewCell.h"
#import "Masonry.h"

@interface MixtureCollecionViewCell ()

@end

@implementation MixtureCollecionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadLabel];
    }
    return self;
}

- (void)loadLabel {
    self.label = [[UILabel alloc]init];
    
    [self addSubview:self.label];
    
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(self.mas_width);
        make.center.equalTo(@0);
    }];
}

@end
