//
//  QNCollectionFormMode.h
//  QNKit
//
//  Created by 研究院01 on 15/12/18.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QNCollectionFormMode <NSObject>

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger numberX;
@property (assign, nonatomic) NSInteger numberY;

@end
