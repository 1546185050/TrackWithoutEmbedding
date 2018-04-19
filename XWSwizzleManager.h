//
//  XWSwizzleManager.h
//  Etion
//
//  Created by dhp on 17/5/8.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

@interface XWSwizzleManager : NSObject

+ (instancetype)shareInstance;
- (void)createAllHooks;

@end
