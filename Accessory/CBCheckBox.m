//
//  CBCheckBox.m
//  Accessory
//
//  Created by 陈冰 on 2017/12/26.
//  Copyright © 2017年 ChenBing. All rights reserved.
//

#import "CBCheckBox.h"

@implementation CBCheckBox
{
    UIColor *_tintColor;
}

- (void)tintColorDidChange {
    [self setNeedsDisplay];
}

- (UIColor *)tintColor {
    if ([[super superclass] respondsToSelector:@selector(tintColor)]) {
        return [super tintColor];
    } else {
        return _tintColor;
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if ([[super superclass] respondsToSelector:@selector(setTintColor:)]) {
        return [super setTintColor:tintColor];
    } else {
        _tintColor = tintColor;
    }
}

- (void)drawRect:(CGRect)rect {
    
    const CGFloat size = MIN(self.bounds.size.width, self.bounds.size.height);
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    if (self.bounds.size.width < self.bounds.size.height) {
        // 垂直居中
        transform = CGAffineTransformMakeTranslation((self.bounds.size.height - size)/2, 0);
    } else if (self.bounds.size.width > self.bounds.size.height) {
        // 水平居中
        transform = CGAffineTransformMakeTranslation((self.bounds.size.width - size)/2, 0);
    }

    // Draw the checkbox
    {
        const CGFloat strokeWidth = 0.068359375f * size;
        const CGFloat checkBoxInset = 0.171875f * size;
        
        CGRect checkBoxRect = CGRectMake(checkBoxInset, checkBoxInset, size - checkBoxInset*2, size - checkBoxInset*2);
        UIBezierPath *checkBoxPath = [UIBezierPath bezierPathWithRect:checkBoxRect];
        
        [checkBoxPath applyTransform:transform];
        
        if (self.tintColor == nil) {
            self.tintColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        }
        [self.tintColor setStroke];
        
        checkBoxPath.lineWidth = strokeWidth;
        
        [checkBoxPath stroke];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.checked) {
    #define P(POINT) (POINT * size)
        CGContextSetGrayFillColor(context, 0.0f, 1.0f);
        CGContextConcatCTM(context, transform);
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context,
                             P(0.304f), P(0.425f));
        CGContextAddLineToPoint(context, P(0.396f), P(0.361f));
        CGContextAddCurveToPoint(context,
                                 P(0.396f), P(0.361f),
                                 P(0.453f), P(0.392f),
                                 P(0.5f), P(0.511f));
        CGContextAddCurveToPoint(context,
                                 P(0.703f), P(0.181f),
                                 P(0.988f), P(0.015f),
                                 P(0.988f), P(0.015f));
        CGContextAddLineToPoint(context, P(0.998f), P(0.044f));
        CGContextAddCurveToPoint(context,
                                 P(0.998f), P(0.044f),
                                 P(0.769f), P(0.212f),
                                 P(0.558f), P(0.605f));
        CGContextAddLineToPoint(context, P(0.458f), P(0.681f));
        CGContextAddCurveToPoint(context,
                                 P(0.365f), P(0.451f),
                                 P(0.304f), P(0.425f),
                                 P(0.302f), P(0.425f));
        CGContextClosePath(context);
        
        CGContextFillPath(context);
    #undef P
    }
}

- (void)setChecked:(BOOL)checked {
    if (_checked != checked) {
        _checked = checked;
        
        [self setNeedsDisplay];
        
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
    }
}

- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents withEvent:(UIEvent *)event {
    
    NSSet *allTargets = [self allTargets];
    
    for (id target in allTargets) {
        NSArray *actionsForTarget = [self actionsForTarget:target forControlEvent:controlEvents];
        
        for (NSString *action in actionsForTarget) {
            SEL selector = NSSelectorFromString(action);
            [self sendAction:selector to:target forEvent:event];
        }
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches anyObject].tapCount == 1) {
        self.checked = !self.checked;
     
        [self sendActionsForControlEvents:UIControlEventValueChanged withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

- (BOOL)isAccessibilityElement {
    return YES;
}

- (UIAccessibilityTraits)accessibilityTraits {
    return super.accessibilityTraits | UIAccessibilityTraitButton;
}

- (NSString *)accessibilityValue {
    return self.checked ? @"Enabled" : @"Disabled";
}

@end
