//
//  QNCollectionFormController.m
//  QNKit
//
//  Created by 研究院01 on 15/12/18.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import "QNCollectionFormController.h"
#import "QNCollectionFormDataSource.h"
#import "QNCollectionFormViewCell.h"
#import "UtilitiesConstants.h"
#import "QNCollectionFormLayout.h"

@interface QNCollectionFormController ()

@property (strong, nonatomic)  QNCollectionFormDataSource *collectionFormDataSource;

@end

@implementation QNCollectionFormController





-(void)viewDidLoad
{
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
        
    UINib *cellViewNib = [UINib nibWithNibName:@"QNCollectionFormViewCell" bundle:nil];
    [self.collectionView registerNib:cellViewNib forCellWithReuseIdentifier:@"QNCollectionFormViewCell"];
    
    
    UINib *headerViewNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"numberX" withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"numberY" withReuseIdentifier:@"HeaderView"];
    
    self.collectionFormDataSource = [[QNCollectionFormDataSource alloc]init];
    self.collectionView.dataSource = self.collectionFormDataSource;
    
    self.collectionFormDataSource.configureCellBlock = ^(QNCollectionFormViewCell *cell, NSIndexPath *indexPath, id<QNCollectionFormMode> event) {
        
        cell.titleLabel.text = @"数据";
    };
    self.collectionFormDataSource.configureHeaderViewBlock = ^(HeaderView *headerView, NSString *kind, NSIndexPath *indexPath) {
        if ([kind isEqualToString:@"numberX"]) {
            headerView.titleLabel.text = [NSString stringWithFormat:@"X %ld", indexPath.item + 1];
        } else if ([kind isEqualToString:@"numberY"]) {
            headerView.titleLabel.text = [NSString stringWithFormat:@"Y %ld", indexPath.item + 1];
        }
    };
}

@end
