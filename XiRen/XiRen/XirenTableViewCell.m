//
//  XirenTableViewCell.m
//  XiRen
//
//  Created by zhuping on 15/4/21.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "XirenTableViewCell.h"

@implementation XirenTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithXirenStyle:(XirenUITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_AVAILABLE_IOS(3_0)
{
    return nil;
}
@end
