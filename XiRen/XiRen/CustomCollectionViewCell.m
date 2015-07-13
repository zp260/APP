//
//  CustomCollectionViewCell.m
//  XiRen
//
//  Created by PIPI on 15/7/10.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell
@synthesize ImgView;
@synthesize Title;
@synthesize ReadNum;
@synthesize HitCount;


-(id)initWithFrame:(CGRect)frame
{
    float BigPicWidth=(kDeviceWidth-15)/2-10;
    float BigPicHeight= BigPicWidth*0.75f;
    self = [super initWithFrame:frame];
    if(self)
    {
        ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, BigPicWidth, BigPicHeight)];
        [self addSubview:ImgView];
        
        Title = [[UILabel alloc]initWithFrame:CGRectMake(5, 15+BigPicHeight, BigPicWidth, 20)];
        [self addSubview:Title];
        
        
        UIImageView *ReadNumPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"play_btn"]];
        ReadNumPic.frame = CGRectMake(5, 40+BigPicHeight, 18, 12);
        ReadNum = [[UILabel alloc]initWithFrame:CGRectMake(5+18+5, 40+BigPicHeight, 50, 12)];
        ReadNum.textColor = [UIColor grayColor];
        [self addSubview:ReadNumPic];
        [self addSubview:ReadNum];
        
        UIImageView *hitPic=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"message_btn"]];
        hitPic.frame = CGRectMake(5+18+5+50, 40+BigPicHeight, 16, 13);
        HitCount = [[UILabel alloc]initWithFrame:CGRectMake(5+18+5+50+16+5, 40+BigPicHeight, 50, 13)];
        HitCount.textColor = [UIColor grayColor];
        [self addSubview:hitPic];
        [self addSubview:HitCount];
        
        
    }
    return self;
}

@end
