//
//  CBAccessoryTableViewController.m
//  Accessory
//
//  Created by 陈冰 on 2017/12/26.
//  Copyright © 2017年 ChenBing. All rights reserved.
//

#import "CBAccessoryTableViewController.h"
// view
#import "CBCustomCell.h"

static NSString *AccessoryCellIdentifier = @"AccessoryCellIdentifier";

@interface CBAccessoryTableViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation CBAccessoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TableData" ofType:@"plist"];
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CBCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:AccessoryCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
