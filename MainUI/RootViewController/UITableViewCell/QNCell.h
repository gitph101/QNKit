//
//  QNCell.h
//  QNKit
//
//  Created by 研究院01 on 15/12/17.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QNCell : UITableViewCell

+ (UINib *)nib;

- (void)configureForPhoto:(NSString *)photo;

@end
