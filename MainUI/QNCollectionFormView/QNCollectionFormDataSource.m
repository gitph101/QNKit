//
//  QNCollectionFormDataSource.m
//  QNKit
//
//  Created by 研究院01 on 15/12/18.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import "QNCollectionFormDataSource.h"
#import "QNSampleMode.h"

@interface QNCollectionFormDataSource ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation QNCollectionFormDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc]init];
        [self generateSampleModeData];
    }
    return self;
}


- (void)generateSampleModeData
{
    //x轴数据
//    for (NSUInteger idx = 0; idx < 7; idx++) {
//        QNSampleMode *mode = [QNSampleMode randomMode];
//        [self.dataSource addObject:mode];
//    }
//    
//    //y轴数据
//    for (NSUInteger idx = 0; idx < 24; idx++) {
//        QNSampleMode *mode = [QNSampleMode randomMode];
//        [self.dataSource addObject:mode];
//    }
    
    //cell 数据
    for (NSUInteger idx = 0; idx < 7; idx++) {
        for (NSUInteger jdx = 0; jdx < 24; jdx++) {
            QNSampleMode *mode = [QNSampleMode randomMode];
            mode.numberX = idx;
            mode.numberY = jdx;
            mode.title = @"数据";
            [self.dataSource addObject:mode];
        }
    }
}

#pragma mark - FormDataSource

- (id<QNCollectionFormMode>)modeAtIndexPath:(NSIndexPath *)indexPath;
{
    return self.dataSource[indexPath.item];
}

- (NSArray *)indexPathsOfEventsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex minStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour
{
    NSMutableArray *indexPaths = [NSMutableArray array];
//    [self.dataSource enumerateObjectsUsingBlock:^(id event, NSUInteger idx, BOOL *stop) {
//        if ([event day] >= minDayIndex && [event day] <= maxDayIndex && [event startHour] >= minStartHour && [event startHour] <= maxStartHour)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
//            [indexPaths addObject:indexPath];
//        }
//    }];
    return indexPaths;
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<QNCollectionFormMode> event = self.dataSource[indexPath.item];
    QNCollectionFormViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QNCollectionFormViewCell" forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        
        self.configureCellBlock(cell, indexPath, event);
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    if (self.configureHeaderViewBlock) {
        self.configureHeaderViewBlock(headerView, kind, indexPath);
    }
    return headerView;
}
@end
