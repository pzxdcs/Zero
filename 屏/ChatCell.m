//
//  ChatCell.m
//  屏
//
//  Created by qingyun on 15/12/8.
//  Copyright © 2015年 zhangxuecheng. All rights reserved.
//

#import "ChatCell.h"
#import "ChatModel.h"

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
    UIImage *image = [UIImage imageNamed:@"chatfrom_bg_normal"];
    [image stretchableImageWithLeftCapWidth:40 topCapHeight:30];
 
}
-(void)setModel:(ChatModel *)model{
    self.type = model.type;
    if (self.type == kChatFrom) {
        self.content.text = model.text;
        self.icon.image = [UIImage imageNamed:@"icon"];
    }else if (self.type == kChatTo){
        self.content.text = model.textTo;
        self.icon.image = [UIImage imageNamed:@"icon2"];
    }
 
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
