//
//  NSObject+QNAddForAlertView.m
//  QNKit
//
//  Created by 研究院01 on 15/12/16.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import "NSObject+QNAddForAlertView.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import <UIKit/UIKit.h>

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

static const int  block_key;

@interface p_QNNbjectAlertViewBlockTarget : NSObject<UIAlertViewDelegate>

@property (nonatomic, copy) AlertBlock cancelButtonBlock;
@property (nonatomic, copy) AlertBlock otherButtonTitleBlock;

@end

@implementation p_QNNbjectAlertViewBlockTarget

- (id)initWithBlock:(AlertBlock)cancelBlock otherBlock:(AlertBlock)otherBlock{
    self = [super init];
    if (self) {
        self.cancelButtonBlock = cancelBlock;
        self.otherButtonTitleBlock =  otherBlock;
    }
    return self;
}
#ifdef __IPHONE_7_0
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0);
{
    if(buttonIndex == 0){
        self.cancelButtonBlock([alertView buttonTitleAtIndex:buttonIndex]);
    }else if(buttonIndex == 1){
        self.otherButtonTitleBlock([alertView buttonTitleAtIndex:buttonIndex]);
    }

}
#else

#endif

@end

@implementation NSObject (QNAddForAlertView)


-(void)addAlertViewWithTitle:(NSString *)titlte message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle cancelButtonTitleBlock:(AlertBlock)cancelButtonTitleBlock otherButtonTitleBlock:(AlertBlock)otherButtonTitleBlock
{
    
    if (iOS8) {
        if (![self isKindOfClass:[UIViewController class]]) {
            return;
        }
        
        __weak typeof(self) viewController = self;
        
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:titlte message:message preferredStyle:UIAlertControllerStyleAlert];
        
        if (cancelButtonTitle) {
            UIAlertAction *cancelButtonAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:NO withObject:nil];
                if (cancelButtonTitleBlock) {
                    cancelButtonTitleBlock(action.title);
                }
            }];
            [alertViewController addAction:cancelButtonAction];
        }
        
        if (otherButtonTitle) {
            UIAlertAction *otherButtonTitleAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:NO withObject:nil];
                if (otherButtonTitleBlock) {
                    otherButtonTitleBlock(action.title);
                }
            }];
            
            [alertViewController addAction:otherButtonTitleAction];
        }
        
        [(UIViewController *)viewController presentViewController:alertViewController animated:YES completion:nil];
        
    }else{
        p_QNNbjectAlertViewBlockTarget *target = [[p_QNNbjectAlertViewBlockTarget alloc]initWithBlock:cancelButtonTitleBlock otherBlock:otherButtonTitleBlock];
        objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:titlte message:message delegate:target cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
        [alertView show];
        
    }
}



@end
