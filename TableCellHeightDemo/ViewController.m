//
//  ViewController.m
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "ViewController.h"
#import "AutoTableVC.h"
#import "AutoMixtureTableVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Go Test >>";
    
    [self loadRightBarItem];
    [self loadLeftBarItem];
}

- (void)loadRightBarItem {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"单cell" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goRight) forControlEvents:UIControlEventTouchUpInside];
    
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(0, 0, 180, 44);
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)loadLeftBarItem {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"混合cell" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goLeft) forControlEvents:UIControlEventTouchUpInside];
    
    btn.backgroundColor = [UIColor purpleColor];
    btn.frame = CGRectMake(0, 0, 180, 44);
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)goRight {
    AutoTableVC * vc = [[AutoTableVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goLeft {
    AutoMixtureTableVC * vc = [[AutoMixtureTableVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
