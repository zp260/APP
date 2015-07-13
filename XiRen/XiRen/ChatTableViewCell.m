//
//  ChatTableViewCell.m
//  XiRen
//
//  Created by PIPI on 15/6/15.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _face =[[UIImageView alloc]initWithFrame:CGRectMake(5.0f, 0.0f, 46.0f, 46.0f)];
        [self addSubview:_face];
        _name = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 0.0f, self.frame.size.width-75.0f, 30.f)];
        
        _message = [[UITextView alloc]initWithFrame:CGRectMake(75.0f, 35.0f, self.frame.size.width-75.0f, self.frame.size.height-35)];
        [_message setAutoresizesSubviews:YES];
        _message.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _message.showsHorizontalScrollIndicator=NO;
        _message.showsVerticalScrollIndicator=NO;
        _message.editable=NO;
        _message.scrollEnabled=NO;
        _message.backgroundColor=[UIColor whiteColor];
        _message.font=[UIFont systemFontOfSize:13.0f];
        //_message.layer.borderColor = [UIColor grayColor].CGColor;
        //_message.layer.borderWidth=0.5f;
        _message.layer.cornerRadius=5.0f;
        
        
        [self addSubview:_name];
        [self addSubview:_message];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
