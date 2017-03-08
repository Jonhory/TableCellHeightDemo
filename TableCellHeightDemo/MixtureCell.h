//
//  MixtureCell.h
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kMixtureCellID = @"kMixtureCellID";

@interface MixtureCell : UITableViewCell

+ (instancetype)configWithTableView:(UITableView *)tableView;

@property(nonatomic, strong) NSMutableArray <NSString *>*titles;

@end
