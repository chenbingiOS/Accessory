//
//  CBAccessoryTableViewController.m
//  Accessory
//
//  Created by 陈冰 on 2017/12/26.
//  Copyright © 2017年 ChenBing. All rights reserved.
//

#import "CBAccessoryTableViewController.h"
// view
#import "CBCheckBox.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccessoryCellIdentifier forIndexPath:indexPath];
    
    if (cell.accessoryView == nil) {
        CBCheckBox *checkBox = [[CBCheckBox alloc] initWithFrame:CGRectMake(0, 0, 25, 43)];
        checkBox.opaque = NO;
        [checkBox addTarget:self action:@selector(checkBoxTaped:forEvent:) forControlEvents:UIControlEventValueChanged];
        
        cell.accessoryView = checkBox;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSDictionary *itmeDict = self.dataArray[indexPath.row];
    cell.textLabel.text = itmeDict[@"text"];
    CBCheckBox *checkBox = (CBCheckBox *)cell.accessoryView;
    checkBox.checked = [itmeDict[@"checked"] boolValue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
    CBCheckBox *targetCheckBox = (CBCheckBox *)targetCell.accessoryView;
    targetCheckBox.checked = !targetCheckBox.checked;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 改变数据
    NSMutableDictionary *selectedItem = self.dataArray[(NSUInteger)indexPath.row];
    selectedItem[@"checked"] = @(targetCheckBox.checked);

    // 刷新UI
    [self updateAccessibilityForCell:targetCell];
}

#pragma mark - Action
- (void)checkBoxTaped:(id)sender forEvent:(UIEvent *)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPositon = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPositon];
    if (indexPath != nil) {
        NSMutableDictionary *selectedItem = self.dataArray[(NSUInteger)indexPath.row];
        selectedItem[@"checked"] = @([(CBCheckBox *)sender isChecked]);
    }
    
    [self updateAccessibilityForCell:[self.tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - Accessibility
- (void)updateAccessibilityForCell:(UITableViewCell *)cell {
    // cell的accessibilityValue 的值是 checkBox 的accessibilityValue
    cell.accessibilityValue = cell.accessoryView.accessibilityValue;
}

@end
