//
//  AutoCell.h
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoModel.h"

static NSString * const kAutoCellID = @"kAutoCellID";

@interface AutoCell : UITableViewCell

+ (instancetype)configWithTableView:(UITableView *)tableView;

@property(nonatomic, strong) AutoModel *model;

@end
