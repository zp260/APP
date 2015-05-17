//
//  UIFont+Extension.m
//  RoomAirQuality
//
//  Created by Zhao Kun on 14-4-19.
//  Copyright (c) 2014年 Anson Zhao. All rights reserved.
//

#import "UIFont+Extension.h"

static NSString * const kUltraLightFontName = @"HelveticaNeue-UltraLight";
static NSString * const kLightFontName = @"HelveticaNeue-Light";
static NSString * const kRegularFontName = @"HelveticaNeue";
static NSString * const kBoldFontName = @"HelveticaNeue-Bold";
static NSString * const kThinFontName = @"HelveticaNeue-Thin";
static NSString * const kMediumFontName = @"HelveticaNeue-Medium";
static NSString * const kFZFontName = @"FZLTHJW--GB1-0";

static NSString * const kSTHeitiSCMediumFontName = @"STHeitiSC-Medium";

@implementation UIFont (Extension)

+ (UIFont *)yaheiFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kFZFontName size:fontSize];
}

+ (UIFont *)regularHelveticaNeueFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kRegularFontName size:fontSize];
}

+ (UIFont *)boldHelveticaNeueFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kBoldFontName size:fontSize];
}

+ (UIFont *)mediumSTHeitiSCFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:kSTHeitiSCMediumFontName size:fontSize];
}

@end
