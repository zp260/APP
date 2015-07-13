//
//  CustomPicTalkCollectionViewCell.m
//  XiRen
//
//  Created by PIPI on 15/7/12.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "CustomPicTalkCollectionViewCell.h"

@implementation CustomPicTalkCollectionViewCell
@synthesize ImgView;
@synthesize Title;
@synthesize ReadNum;
@synthesize HitCount;
-(id)initWithFrame:(CGRect)frame
{
    float BigPicWidth=(kDeviceWidth-15)/3-10;
    float BigPicHeight= BigPicWidth*0.75f;
    float readNumWidth=30;
    self = [super initWithFrame:frame];
    if(self)
    {
        ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, BigPicWidth, BigPicHeight)];
        [self addSubview:ImgView];
        
        Title = [[UILabel alloc]initWithFrame:CGRectMake(5, 15+BigPicHeight, BigPicWidth, 20)];
        [self addSubview:Title];
        Title.font = [UIFont systemFontOfSize:15];
        
        
        UIImageView *ReadNumPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"play_btn"]];
        ReadNumPic.frame = CGRectMake(5, 40+BigPicHeight, 18, 12);
        ReadNum = [[UILabel alloc]initWithFrame:CGRectMake(5+18+5, 40+BigPicHeight, readNumWidth, 12)];
        [self MakeLableFontStyleToSame:ReadNum];
        [self addSubview:ReadNumPic];
        [self addSubview:ReadNum];
        
        UIImageView *hitPic=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"message_btn"]];
        hitPic.frame = CGRectMake(5+18+5+readNumWidth, 40+BigPicHeight, 16, 13);
        HitCount = [[UILabel alloc]initWithFrame:CGRectMake(5+18+5+readNumWidth+16+5, 40+BigPicHeight, readNumWidth, 13)];
        [self MakeLableFontStyleToSame:HitCount];
        [self addSubview:hitPic];
        [self addSubview:HitCount];
        
        
    }
    return self;
}
-(void)MakeLableFontStyleToSame:(UILabel *)lable
{
    lable.textColor = [UIColor grayColor];
    lable.font  = [UIFont systemFontOfSize:10];

}

@end
