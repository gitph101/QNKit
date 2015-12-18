//
//  NSObject+QNAddForAlertView.h
//  QNKit
//
//  Created by 研究院01 on 15/12/16.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/objc.h>
#import <objc/runtime.h>
#import "UtilitiesMacro.h"
typedef  void (^AlertBlock)(__weak id obj);

@interface NSObject (QNAddForAlertView)
/**
 *  警告框 兼容iOS7.8.9
 *
 *  @param titlte                 titlte description
 *  @param message                message description
 *  @param cancelButtonTitle      cancelButtonTitle description
 *  @param otherButtonTitle       otherButtonTitle description
 *  @param cancelButtonTitleBlock  取消回调block 参数是title
 *  @param otherButtonTitleBlock   确定回调block 参数是title
 */
-(void)addAlertViewWithTitle:(NSString *)titlte message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle cancelButtonTitleBlock:(AlertBlock)cancelButtonTitleBlock otherButtonTitleBlock:(AlertBlock)otherButtonTitleBlock;

@end
