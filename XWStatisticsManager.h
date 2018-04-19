//
//  XWStatisticsManager.h
//  Etion
//
//  Created by dhp on 17/5/8.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWStatisticsManager : NSObject

+ (instancetype)shareInstance;
- (void)beginCollectXWStatistics;
@end
