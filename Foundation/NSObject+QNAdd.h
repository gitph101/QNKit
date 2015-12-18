//
//  NSObject+QNAdd.h
//  QNKit
//
//  Created by 研究院01 on 15/12/15.
//  Copyright © 2015年 qyear. All rights reserved.
//
#import "UtilitiesMacro.h"
#import <Foundation/Foundation.h>



@interface NSObject (QNAdd)

-(id)performSelectorWithArgs:(SEL)sel, ...;

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

- (void)setAssociateValue:(id)value withKey:(void *)key;

- (void)setAssociateWeakValue:(id)value withKey:(void *)key;
- (void)removeAssociatedValues;
- (id)getAssociatedValueForKey:(void *)key;
+ (NSString *)className;
- (NSString *)className ;
@end
