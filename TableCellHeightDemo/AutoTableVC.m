//
//  AutoTableVC.m
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "AutoTableVC.h"
#import "AutoCell.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@implementation UIColor (RandomColor)
+(UIColor *) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end

@interface AutoTableVC () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray <AutoModel *>*datas;

@end

@implementation AutoTableVC

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
    AutoCell * cell = [AutoCell configWithTableView:tableView];
    cell.model = self.datas[indexPath.row];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
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

- (NSMutableArray<AutoModel *> *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray alloc]init];
        for (int i = 0 ; i<arc4random()%200; i++) {
            AutoModel * model = [AutoModel random];
            [_datas addObject:model];
        }
    }
    return _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
