//
//  QNCell.m
//  QNKit
//
//  Created by 研究院01 on 15/12/17.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import "QNCell.h"

@implementation QNCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"QNCell" bundle:nil];
}

- (void)configureForPhoto:(NSString *)photo
{
    self.textLabel.text = photo;
}

@end
