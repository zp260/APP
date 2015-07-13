//
//  ChatTableViewCell.h
//  XiRen
//
//  Created by PIPI on 15/6/15.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell

@property (retain,nonatomic) UITextView *message;
@property (retain,nonatomic) UIImageView *face;
@property (retain,nonatomic) UILabel *name;

@end
