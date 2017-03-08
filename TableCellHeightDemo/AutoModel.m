//
//  AutoModel.m
//  TableCellHeightDemo
//
//  Created by Jonhory on 2017/3/8.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "AutoModel.h"

@implementation AutoImageModel

@end

@implementation AutoModel

- (NSMutableArray<AutoImageModel *> *)images {
    if (!_images) {
        _images = [[NSMutableArray alloc]init];
    }
    return _images;
}

+ (instancetype)random {
    AutoModel * model = [[AutoModel alloc]init];
    model.content = [NSString stringWithFormat:@"我的事离开首都法拉盛带你飞了sad 家乐福控件撒点开了房间看拉萨的疯狂了时间弗兰克的撒娇款礼服就撒的六块腹肌啊圣诞快乐；积分快来；地税局分开了；%@分快来；地税局分开了",[self randomStrWithLength:arc4random()%200]];
    model.phone = [self randomStrWithLength:arc4random()%30];
    model.time = [self randomStrWithLength:12];
    model.encourage = arc4random()%100;
    model.talk = arc4random()%200;
    
    for (int i = 0; i<arc4random()%3; i++) {
        AutoImageModel * image = [[AutoImageModel alloc]init];
        image.defaultImageName = [NSString stringWithFormat:@"%d",arc4random()%3];
        [model.images addObject:image];
    }
    
    return  model;
}

+ (NSString *)randomStrWithLength:(int)length{
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
