//
//  QNSampleMode.m
//  QNKit
//
//  Created by 研究院01 on 15/12/18.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import "QNSampleMode.h"

@implementation QNSampleMode

@synthesize title = _title;
@synthesize numberX = _numberX;
@synthesize numberY = _numberY;

+ (instancetype)randomMode
{
    uint32_t randomID = arc4random_uniform(10000);
    NSString *title = [NSString stringWithFormat:@"单元格数据 #%u", randomID];
    uint32_t randomX = arc4random_uniform(7);
    uint32_t randomY = arc4random_uniform(20);
    
    return [self eventWithTitle:title numberX:randomX numberY:randomY];
}
+ (instancetype)eventWithTitle:(NSString *)title numberX:(NSUInteger)numberX numberY:(NSUInteger)numberY
{
    return [[self alloc]initWithTitle:title numberX:numberX numberY:numberY];
}

- (instancetype)initWithTitle:(NSString *)title numberX:(NSUInteger)numberX numberY:(NSUInteger)numberY

{
    self = [super init];
    if (self != nil) {
        _title = [title copy];
        _numberY = numberX;
        _numberY = numberY;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: X %ld - Y %ld", self.title, (long)self.numberX, (long)self.numberY];
}
@end
