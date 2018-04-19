//
//  UIGestureRecognizer+XW.m
//  Etion
//
//  Created by dhp on 17/5/9.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import "UIGestureRecognizer+XW.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UITextFieldExtend.h"
#import "UIView+XWStatistics.h"
@class UITextInteractionAssistant;

NSString * const xw_btnClickedCountKey1 = nil;
NSString * const xw_btnCurrentActionBlockKey1 = nil;

@implementation UITapGestureRecognizer (XW)
//@dynamic currentActionBlock1;
//@dynamic btnClickedCount1;
//+ (void)load{
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        SEL origilaSEL = @selector(initWithTarget:action:);
//        
//        SEL hook_SEL = @selector(xw_initWithTarget:action:);
//        
//        //交换方法
//        Method origilalMethod = class_getInstanceMethod(self, origilaSEL);
//        
//        
//        Method hook_method = class_getInstanceMethod(self, hook_SEL);
//        
//        
//        class_addMethod(self,
//                        origilaSEL,
//                        class_getMethodImplementation(self, origilaSEL),
//                        method_getTypeEncoding(origilalMethod));
//        
//        class_addMethod(self,
//                        hook_SEL,
//                        class_getMethodImplementation(self, hook_SEL),
//                        method_getTypeEncoding(hook_method));
//        
//        method_exchangeImplementations(class_getInstanceMethod(self, origilaSEL), class_getInstanceMethod(self, hook_SEL));
//        
//    });
//    
//}
- (instancetype)xw_initWithTarget:(nullable id)target action:(SEL)action{
//- (void)xw_addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    self.delegate = self;
    
    __weak __typeof(target) weakTarget = target;
    
    __weak __typeof(self) weakSelf = self;
    
    //利用 关联对象 给增加了一个 block
    if (action) {
        
        [self  setcurrentActionBlock1:^{
            @try {
                ((void (*)(void *, SEL,  __typeof(weakSelf) ))objc_msgSend)((__bridge void *)(weakTarget), action , weakSelf);
            } @catch (NSException *exception) {
            } @finally {
            }
            
        }];
    }
    
    
    //发送消息 其实是本身  要执行的action 先执行，写下来的 xw_clicked:方法
//    if (![NSStringFromSelector(action) isEqualToString:@"oneFingerTap:"] && ![NSStringFromSelector(action) isEqualToString:@"oneFingerDoubleTap:"]) {
        [self xw_initWithTarget:self action:@selector(xw_tap:)];
//        [self xw_initWithTarget:self action:action];
//    }
//    else
//    {
////        Class class = [UITextInteractionAssistant class];
////        NSLog(@"%@",class);
//        if ([self.view respondsToSelector:@selector(oneFingerTap:)]) {
//            [self.view performSelector:@selector(oneFingerTap:) withObject:target];
//        }
//    }
//        [self xw_initWithTarget:self action:action];
//        [self xw_initWithTarget:self action:@selector(xw_tap:)];
    return self;
//    [self xw_addTarget:self action:@selector(xw_clicked:) forControlEvents:controlEvents];
}
-(void)xw_tap:(UITapGestureRecognizer *)tap{
    self.btnClickedCount1 = self.btnClickedCount1 + 1;
    NSLog(@"手势次数%ld",self.btnClickedCount1);
//    if ([self.view isKindOfClass:[UITextField class]]) {
//        [self.view isFirstResponder];
//    }
    NSLog(@"点击次数:%@",[tap.view viewPathString]);
    
////    if ([tap respondsToSelector:@selector(oneFingerTap:)]) {
//        [tap performSelector:@selector(oneFingerTap:) withObject:tap];
////    }
////    else
//        [self currentActionBlock1];
    tap.currentActionBlock1();
}

//增加一个 block 关联
- (void)setcurrentActionBlock1:(void (^)())currentActionBlock1{
    
    objc_setAssociatedObject(self, &xw_btnCurrentActionBlockKey1, currentActionBlock1, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())currentActionBlock1{
    return objc_getAssociatedObject(self, &xw_btnCurrentActionBlockKey1);
}


#pragma mark -统计

//在分类中增加了 btnClickedCount1的 (setter 和 getter）方法，使用关联对象增加了相关的成员空间
- (NSInteger)btnClickedCount1{
    id tmp = objc_getAssociatedObject(self, &xw_btnClickedCountKey1);
    NSNumber *number = tmp;
    return number.integerValue;
}


- (void)setBtnClickedCount1:(NSInteger)btnClickedCount1{
    objc_setAssociatedObject(self, &xw_btnClickedCountKey1, @(btnClickedCount1), OBJC_ASSOCIATION_ASSIGN);
}

//#pragma mark -delegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
////    if ([touch.view isKindOfClass:[UIButton class]]) {
////        return NO;
////    }
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return YES;
//}
@end
