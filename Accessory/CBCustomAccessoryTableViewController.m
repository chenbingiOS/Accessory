//
//  CBCustomAccessoryTableViewController.m
//  Accessory
//
//  Created by 陈冰 on 2017/12/26.
//  Copyright © 2017年 ChenBing. All rights reserved.
//

#import "CBCustomAccessoryTableViewController.h"
// cell
#import "CBCustomCell.h"
#import "CBCheckBox.h"
// VC
#import "CBDetailViewController.h"

static NSString *CustomAccessoryCellIdentifier = @"CustomAccessoryCellIdentifier";

@interface CBCustomAccessoryTableViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation CBCustomAccessoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TableData" ofType:@"plist"];
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 后面的页面返回这个页面
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CBCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomAccessoryCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *item = self.dataArray[(NSUInteger)indexPath.row];
    cell.titleLabel.text = item[@"text"];
    cell.checkBox.checked = [item[@"checked"] boolValue];
    
    [self updateAccessibilityForCell:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CBCustomCell *targetCustomCell = [tableView cellForRowAtIndexPath:indexPath];
    targetCustomCell.checkBox.checked = !targetCustomCell.checkBox.checked;
    
    NSMutableDictionary *selectedItem = self.dataArray[(NSUInteger)indexPath.row];
    selectedItem[@"checked"] = @(targetCustomCell.checkBox.checked);
    
    [self updateAccessibilityForCell:targetCustomCell];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)checkBoxTaped:(id)sender forEvent:(UIEvent *)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil) {
        NSMutableDictionary *selectedItem = self.dataArray[(NSUInteger)indexPath.row];
        selectedItem[@"checked"] = @([(CBCheckBox *)sender isChecked]);
    }
    
    [self updateAccessibilityForCell:(CBCustomCell *)[self.tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - Accessibility
- (void)updateAccessibilityForCell:(CBCustomCell *)cell {
    
    cell.accessibilityValue = cell.checkBox.accessibilityValue;
    cell.checkBox.accessibilityValue = cell.titleLabel.text;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CBDeatilViewCtrlSegue"]) {
        CBDetailViewController *destinationOfDetialVC = (CBDetailViewController *)segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
        destinationOfDetialVC.item = self.dataArray[(NSUInteger)selectedIndexPath.row];
    }
}

@end
