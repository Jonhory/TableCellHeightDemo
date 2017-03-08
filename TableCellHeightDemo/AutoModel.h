/*!
 @header AutoModel.h
 
 @abstract 基本描述
 
 @author Created by Jonhory on 2017/3/8.
 
 @version 1.00 2017/3/8Creation
 
   Copyright © 2017年 com.wujh. All rights reserved.
 
 */

#import <Foundation/Foundation.h>

@interface AutoImageModel : NSObject

@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *defaultImageName;

@end

@interface AutoModel : NSObject

@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, assign) NSUInteger encourage;
@property(nonatomic, assign) NSUInteger talk;

@property(nonatomic, strong) NSMutableArray <AutoImageModel *> *images;

+ (instancetype)random;

@end
