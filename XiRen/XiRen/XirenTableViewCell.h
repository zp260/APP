//
//  XirenTableViewCell.h
//  XiRen
//
//  Created by zhuping on 15/4/21.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XirenUITableViewCellStyle) {
        UITableViewCellStyleXiren	// Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).
};

@interface XirenTableViewCell : UITableViewCell

- (instancetype)initWithXirenStyle:(XirenUITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_AVAILABLE_IOS(3_0);

@property (nonatomic, readonly, retain) UIImageView *_TopImageview NS_AVAILABLE_IOS(3_0);
@property (nonatomic, readonly, retain) UILabel     *_TitletextLabel NS_AVAILABLE_IOS(3_0);
@property (nonatomic, readonly, retain) UILabel     *_IntroTextLabel NS_AVAILABLE_IOS(3_0);
@end
