//
//  QNCollectionFormDataSource.h
//  QNKit
//
//  Created by 研究院01 on 15/12/18.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNCollectionFormMode.h"
#import "QNCollectionFormViewCell.h"
#import "HeaderView.h"

typedef void (^ConfigureCellBlock)(QNCollectionFormViewCell *cell, NSIndexPath *indexPath, id<QNCollectionFormMode> event);
typedef void (^ConfigureHeaderViewBlock)(HeaderView *headerView, NSString *kind, NSIndexPath *indexPath);


@interface QNCollectionFormDataSource : NSObject<UICollectionViewDataSource>

@property (copy, nonatomic) ConfigureCellBlock configureCellBlock;
@property (copy, nonatomic) ConfigureHeaderViewBlock configureHeaderViewBlock;

- (id<QNCollectionFormMode>)modeAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)indexPathsOfEventsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex minStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour;


@end
