//
//  CBDetailViewController.m
//  Accessory
//
//  Created by 陈冰 on 2017/12/26.
//  Copyright © 2017年 ChenBing. All rights reserved.
//

#import "CBDetailViewController.h"
#import "CBCheckBox.h"

@interface CBDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet CBCheckBox *checkBox;

@end

@implementation CBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.item[@"text"];
    self.titleLabel.text = self.item[@"text"];
    self.checkBox.checked = [self.item[@"checked"] boolValue];
    
    self.checkBox.accessibilityValue = self.item[@"text"];
}

- (IBAction)checkBoxHandle:(CBCheckBox *)sender {
    self.item[@"checked"] = @(self.checkBox.checked);
}


@end
