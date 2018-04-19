//
//  UIGestureRecognizer+XW.h
//  Etion
//
//  Created by dhp on 17/5/9.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapGestureRecognizer (XW) <UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger  btnClickedCount1;

@property (nonatomic, copy) void (^currentActionBlock1)() ;

@end
