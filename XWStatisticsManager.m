//
//  XWStatisticsManager.m
//  Etion
//
//  Created by dhp on 17/5/8.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import "XWStatisticsManager.h"
#import "XWSwizzleManager.h"

@implementation XWStatisticsManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static XWStatisticsManager *statisticsManager = nil;
    dispatch_once(&onceToken, ^{
        statisticsManager = [[XWStatisticsManager alloc] init];
    });
    return statisticsManager;
}

- (void)beginCollectXWStatistics
{
    //Swizzle
    XWSwizzleManager *swizzleManager = [XWSwizzleManager shareInstance];
    [swizzleManager createAllHooks];
    
    //deviceInfo
    [self getDeviceInfo];
    
}

- (void)getDeviceInfo
{
//    NSString *type = [UIDevice iphoneType];
//    NSInteger usedMemory = [UIDevice currentUsedMemory];
//    NSInteger availableMemory = [UIDevice currentAvailableMemory];
//    NSLog(@"设备信息==类型:%@--已用内存:%ld--可用内存:%ld\n",type,usedMemory,availableMemory);
    
}
@end
