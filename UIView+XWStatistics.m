//
//  UIView+XWStatistics.m
//  Etion
//
//  Created by dhp on 17/5/10.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import "UIView+XWStatistics.h"
#import "Aspects.h"

NSString * const xw_viewPath = nil;

@implementation UIView (XWStatistics)

@dynamic viewPathString;

#pragma mark -public method
+ (void)handleViewStatisticsSwizzle
{
    [UIView aspect_hookSelector:@selector(drawLayer:inContext:)
                    withOptions:AspectPositionAfter
                     usingBlock:^(id<AspectInfo> info){
                         
                         UIView *view = (UIView *)[info instance];
                         NSMutableString *viewPathStr = [view buildViewPath:view index:0 viewPathStr:[NSMutableString string]];
                         if (viewPathStr.length > 0) {
                             NSLog(@"\n视图类型----%@", [info instance]);
                             view.viewPathString = viewPathStr;
                             NSLog(@"\n视图路径----%@\n",viewPathStr);
                         }
                     }
                          error:nil];
    
}

#pragma mark -private method
- (NSMutableString *)buildViewPath:(UIView *)view index:(NSInteger)index viewPathStr:(NSMutableString *)viewPathStr
{
    id nextresponder = [view nextResponder];
    index ++;
    
    NSMutableString *markStr = [NSMutableString string];
    
    for (NSInteger i = 0; i < index; i ++) {
        [markStr appendString:@"-"];
    }
    
    if (nextresponder != nil ) {
        NSLog(@"%@%@",markStr,[[nextresponder class] description]);
        [viewPathStr appendString:[NSString stringWithFormat:@"%@",[[nextresponder class] description]]];
        
        if ([nextresponder isKindOfClass:[UIView class]] == YES) {
            NSInteger subIndex = [[nextresponder subviews] indexOfObject:view];
            [viewPathStr appendString:[NSString stringWithFormat:@"[%ld]/",subIndex]];
        }
        
        [self buildViewPath:nextresponder index:index++ viewPathStr:viewPathStr];
    }
    
    return viewPathStr;
}

#pragma mark -getter && setter
- (NSString *)viewPathString{
    id tmp = objc_getAssociatedObject(self, &xw_viewPath);
    return tmp;
}

- (void)setViewPathString:(NSString *)viewPathString{
    objc_setAssociatedObject(self, &xw_viewPath, viewPathString, OBJC_ASSOCIATION_COPY);
}
@end
