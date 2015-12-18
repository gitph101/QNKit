//
//  ViewController.m
//  QNKit
//
//  Created by 研究院01 on 15/12/15.
//  Copyright © 2015年 qyear. All rights reserved.
//

#import "ViewController.h"
#import "UtilitiesClass.h"
#import "DataSource.h"
#import "QNCell.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import "QNCollectionFormController.h"
#import "QNCollectionFormLayout.h"
static NSString * const PhotoCellIdentifier = @"PhotoCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) DataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Main";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];

}


- (void)setupTableView
{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    TableViewCellConfigureBlock configureCell = ^(QNCell *cell, NSString *photo) {
        [cell configureForPhoto:photo];
    };
    _dataArray= [NSArray arrayWithObjects:@"QNCollectionFormController",@"2", nil];
    self.dataSource = [[DataSource alloc]initWithItems:_dataArray cellIdentifier:PhotoCellIdentifier configureCellBlock:configureCell];

    self.tableView.dataSource = self.dataSource;
   [self.tableView registerNib:[QNCell nib] forCellReuseIdentifier:PhotoCellIdentifier];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QNCollectionFormLayout *collectionFormLayout = [[QNCollectionFormLayout alloc]init];
    QNCollectionFormController *collectionView= [[QNCollectionFormController alloc]initWithCollectionViewLayout:collectionFormLayout];
    
    [self presentViewController:collectionView animated:YES completion:nil];
    
}

@end
