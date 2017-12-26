//
//  CBCheckBox.h
//  Accessory
//
//  Created by 陈冰 on 2017/12/26.
//  Copyright © 2017年 ChenBing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBCheckBox : UIControl

@property (assign, nonatomic, getter=isChecked) BOOL checked;
@property (strong, nonatomic) UIColor *tintColor;

@end
