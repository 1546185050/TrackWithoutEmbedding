//
//  UIView+XWStatistics.h
//  Etion
//
//  Created by dhp on 17/5/10.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XWStatistics)

@property (nonatomic, copy) NSString *viewPathString;

+ (void)handleViewStatisticsSwizzle;
@end
