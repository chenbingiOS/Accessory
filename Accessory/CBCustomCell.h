//
//  CBCustomCell.h
//  Accessory
//
//  Created by 陈冰 on 2017/12/26.
//  Copyright © 2017年 ChenBing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBCheckBox;
@interface CBCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet CBCheckBox *checkBox;

@end
