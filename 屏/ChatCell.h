//
//  ChatCell.h
//  屏
//
//  Created by qingyun on 15/12/8.
//  Copyright © 2015年 zhangxuecheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;//头像
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconLayout;
@property (assign, nonatomic) ChatType type;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWigth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHight;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backGroundWigth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backGroundHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backGroundLayout;


-(void)setModel:(ChatModel *)model;

@end
