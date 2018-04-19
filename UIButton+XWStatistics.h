//
//  UIButton+XWStatistics.h
//  Etion
//
//  Created by dhp on 17/5/12.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XWStatistics)
@property (nonatomic, assign) NSInteger  btnClickedCount;

@property (nonatomic, copy) void (^currentActionBlock)() ;

@end
