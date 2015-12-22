//
//  QNCollectionFormLayout.m
//  QNKit
//
//  Created by 研究院01 on 15/12/18.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import "QNCollectionFormLayout.h"
#import "QNCollectionFormDataSource.h"
#import "QNCollectionFormMode.h"

static const NSUInteger X = 7;
static const NSUInteger Y = 24;
static const CGFloat yHeaderSpacing = 60;//竖向第一列单元格长度
static const CGFloat xHeaderHeight = 30;//横向第一列单元格告诉
static const CGFloat headerSpacing =60;//每一个单元格长度
static const CGFloat headerHeight = 30;//每一个单元格高度


@interface QNCollectionFormLayout ()

@end


@implementation QNCollectionFormLayout


#pragma mark - UICollectionViewLayout Implementation


- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    
    // Scroll vertically to display a full day
    CGFloat contentHeight = xHeaderHeight + (headerHeight * Y);
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
        
    return contentSize;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    // Supplementary views
    NSArray *dayHeaderViewIndexPaths = [self indexPathsOfDayHeaderViewsInRect:rect];
    
    for (NSIndexPath *indexPath in dayHeaderViewIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"numberX" atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    NSArray *hourHeaderViewIndexPaths = [self indexPathsOfHourHeaderViewsInRect:rect];
    for (NSIndexPath *indexPath in hourHeaderViewIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"numberY" atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    return layoutAttributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QNCollectionFormDataSource *dataSource = self.collectionView.dataSource;
    id<QNCollectionFormMode> event = [dataSource modeAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameForEvent:event];
    return attributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    
    CGFloat totalWidth = [self collectionViewContentSize].width;
    if ([kind isEqualToString:@"numberX"]) {
        CGFloat availableWidth = totalWidth - yHeaderSpacing;
        CGFloat widthPerDay = availableWidth / X;
        attributes.frame = CGRectMake(yHeaderSpacing + (widthPerDay * indexPath.item), 0, widthPerDay, xHeaderHeight);
//        attributes.zIndex = -10;
    } else if ([kind isEqualToString:@"numberY"]) {
        attributes.frame = CGRectMake(0, xHeaderHeight + headerHeight * indexPath.item, headerSpacing, headerHeight);
//        attributes.zIndex = -10;
    }
    return attributes;
}


#pragma mark - Helpers

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect
{
    
    NSMutableArray *indexPaths = [NSMutableArray array];
//    for (NSUInteger idx = 1; idx < 8; idx++) {
//        for (NSUInteger jdx = 1; jdx < 25; jdx++) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:jdx*idx inSection:0];
//            [indexPaths addObject:indexPath];
//        }
//    }
    
    
//   NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = 0; idx < X * Y; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (NSInteger)dayIndexFromXCoordinate:(CGFloat)xPosition
{
    CGFloat contentWidth = [self collectionViewContentSize].width - yHeaderSpacing;
    CGFloat widthPerDay = contentWidth / X;
    NSInteger dayIndex = MAX((NSInteger)0, (NSInteger)((xPosition - yHeaderSpacing) / widthPerDay));
    return dayIndex;
}


- (NSArray *)indexPathsOfDayHeaderViewsInRect:(CGRect)rect
{
//    if (CGRectGetMinY(rect) > xHeaderHeight) {
//        return [NSArray array];
//    }
    /*
    NSInteger minDayIndex = [self dayIndexFromXCoordinate:CGRectGetMinX(rect)];
    NSInteger maxDayIndex = [self dayIndexFromXCoordinate:CGRectGetMaxX(rect)];
    */
    
    NSInteger minDayIndex = 0;
    NSInteger maxDayIndex = X;
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = minDayIndex; idx < maxDayIndex; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}


- (NSInteger)hourIndexFromYCoordinate:(CGFloat)yPosition
{
    NSInteger hourIndex = MAX((NSInteger)0, (NSInteger)((yPosition - xHeaderHeight) / headerHeight));
    return hourIndex;
}

- (NSArray *)indexPathsOfHourHeaderViewsInRect:(CGRect)rect
{
    if (CGRectGetMinX(rect) > headerSpacing) {
        return [NSArray array];
    }
    
    NSInteger minHourIndex =  0;
    NSInteger maxHourIndex = Y;
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = minHourIndex; idx < maxHourIndex; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}


- (CGRect)frameForEvent:(id<QNCollectionFormMode>)event
{
    CGFloat totalWidth = [self collectionViewContentSize].width - yHeaderSpacing;
    CGFloat widthPerDay = totalWidth / X;
    CGRect frame = CGRectZero;
    frame.origin.x = yHeaderSpacing + widthPerDay * event.numberX;
    frame.origin.y = xHeaderHeight + headerHeight * event.numberY;
    frame.size.width = widthPerDay;
    frame.size.height = headerHeight;
//    frame = CGRectInset(frame, yHeaderSpacing/2.0, 0);
    return frame;
}

@end
