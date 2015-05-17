//
//  UIImage+Extension.h
//  RoomAirQuality
//
//  Created by Zhao Kun on 14-5-7.
//  Copyright (c) 2014年 Anson Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)scaleAndRotateImage:(UIImage *)image maxSize:(CGFloat)maxSize;

@end
