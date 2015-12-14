//
//  ChatModel.m
//  屏
//
//  Created by qingyun on 15/12/8.
//  Copyright © 2015年 zhangxuecheng. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    self.text = dic[@"text"];
 
   
    return self;
}

@end
