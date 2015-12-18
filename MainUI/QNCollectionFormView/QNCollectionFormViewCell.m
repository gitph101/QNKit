//
//  QNCollectionFormViewCell.m
//  QNKit
//
//  Created by 研究院01 on 15/12/18.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import "QNCollectionFormViewCell.h"

@implementation QNCollectionFormViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0.7 alpha:1] CGColor];
}

@end
