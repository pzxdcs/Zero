//
//  ChatModel.h
//  屏
//
//  Created by qingyun on 15/12/8.
//  Copyright © 2015年 zhangxuecheng. All rights reserved.
//
typedef enum {
    kChatFrom=0,
    kChatTo
}ChatType;
#import <Foundation/Foundation.h>
@interface ChatModel : NSObject
@property (assign, nonatomic) ChatType type;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *textTo;


-(instancetype)initWithDic:(NSDictionary *)dic;
@end
