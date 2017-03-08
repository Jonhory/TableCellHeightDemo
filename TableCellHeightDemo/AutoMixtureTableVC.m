//
//  AutoMixtureTableVC.m
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "AutoMixtureTableVC.h"
#import "AutoCell.h"
#import "MixtureCell.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@implementation UIColor (RandomColor)
+(UIColor *) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end

@interface AutoMixtureTableVC () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *datas;

@end

@implementation AutoMixtureTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"自动高度";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadTable];
}

- (void)loadTable {
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return <#heightForRow#>;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    id model = self.datas[indexPath.row];
    if ([model isKindOfClass:[AutoModel class]]) {
        AutoCell * cell = [AutoCell configWithTableView:tableView];
        cell.model = model;
        cell.backgroundColor = [UIColor randomColor];
        return cell;
    } else {
        MixtureCell * cell = [MixtureCell configWithTableView:tableView];
        cell.titles = model;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    printf("clicked %ld",indexPath.row);
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN.width, SCREEN.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
#warning 关键代码 必须给一个大于0的值,据说给的值越接近真实值，则自动计算得越快
        _tableView.estimatedRowHeight = 10;
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray alloc]init];
        for (int i = 0 ; i < arc4random()%50 + 1; i++) {
            if (arc4random()%2 == 0) {
                NSMutableArray * arr = [[NSMutableArray alloc]init];
                for (int j = 0; j < arc4random()%10 + 1; j++) {
                    NSString * str = [self randomStrWithLength:arc4random()%50+1];
                    [arr addObject:str];
                }
                NSLog(@"增加了 <>>> %@",arr);
                [_datas addObject:arr];
            } else {
                AutoModel * model = [AutoModel random];
                [_datas addObject:model];
            }
        }
    }
    return _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSString *)randomStrWithLength:(int)length{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < length; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

@end
