//
//  XWSwizzleManager.m
//  Etion
//
//  Created by dhp on 17/5/8.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import "XWSwizzleManager.h"
#import <UIKit/UIKit.h>
#import "RichTextViewController.h"
#import "UIView+XWStatistics.h"
#import "UITableView+XWStatistics.h"

@implementation XWSwizzleManager
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static XWSwizzleManager *swizzleManager = nil;
    dispatch_once(&onceToken, ^{
        swizzleManager = [[XWSwizzleManager alloc] init];
    });
    return swizzleManager;
}

- (void)createAllHooks
{
    //UIView
    [UIView handleViewStatisticsSwizzle];
    
    //1.UIApplication
    [UIApplication aspect_hookSelector:@selector(sendAction:to:from:forEvent:)
                           withOptions:AspectPositionAfter
                            usingBlock:^(id<AspectInfo> info){
                                NSLog(@"---按钮点击---");
                                if ([[info instance] isKindOfClass:[UIView class]]) {
                                    NSLog(@"---按钮路径：%@",[[info instance] viewPathString]);
                                }
                            }
                                 error:nil];
    
    //2.UIGestureRecognizer
    [UIGestureRecognizer aspect_hookSelector:@selector(initWithTarget:action:)
                                 withOptions:AspectPositionAfter
                                  usingBlock:^(id<AspectInfo>info,id target,SEL action){
                                      [target aspect_hookSelector:action
                                                      withOptions:AspectPositionAfter
                                                       usingBlock:^(id<AspectInfo> info){
                                                           NSLog(@"---收集手势----");
                                                           NSLog(@"---目标路径：%@",[[info instance] viewPathString]);
                                                       }
                                                            error:nil];
                                  }
                                       error:nil];
    
    //3.UITableView
    [UITableView aspect_hookSelector:@selector(setDelegate:)
                         withOptions:AspectPositionAfter
                          usingBlock:^(id<AspectInfo> info){
                              UITableView *table = (UITableView *)[info instance];
                              id delegate = table.delegate;
                              [delegate aspect_hookSelector:@selector(tableView:didSelectRowAtIndexPath:)
                                                withOptions:AspectPositionAfter
                                                 usingBlock:^(id<AspectInfo> info){
                                                     NSLog(@"---点击列表cell---");
                                                 }
                                                      error:nil ];
                          }
                               error:nil];
    
    //4.UICollectionView
    [UICollectionView aspect_hookSelector:@selector(setDelegate:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> info){
                                   UITableView *table = (UITableView *)[info instance];
                                   id delegate = table.delegate;
                                   [delegate aspect_hookSelector:@selector(collectionView:didSelectItemAtIndexPath:)
                                                     withOptions:AspectPositionAfter
                                                      usingBlock:^(id<AspectInfo> info){
                                                          NSLog(@"---点击九宫格---");
                                                      }
                                                           error:nil ];
                               } error:nil];
    
    //5.alertView
    
    //6.UINavigationController
    
    
    //UIViewController
    [UIViewController aspect_hookSelector:@selector(viewDidLoad)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> info){
                                   //用户统计代码写在此处
                                   NSLog(@"[ASPECT] inject in class instance:%@", [info instance]);
                               }
                                    error:NULL];
    
    //CRichTextViewController
    [CRichTextViewController aspect_hookSelector:@selector(InitRTCtrl:)
                                     withOptions:AspectPositionAfter
                                      usingBlock:^(id<AspectInfo> info){
                                          //用户统计代码写在此处
                                          NSLog(@"丰富文本：[ASPECT] inject in class instance:%@", [info instance]);
                                          CRichTextViewController *richtextVc = (CRichTextViewController *)[info instance];
                                          NSString *guidStr = richtextVc.m_rt.m_attribute.m_szID;
                                          NSString *titleStr = richtextVc.m_rt.m_attribute.m_szTitle;
                                          NSLog(@"---丰富文本测试：%@：%@",guidStr,titleStr);
                                      }
                                           error:NULL];
}

@end
