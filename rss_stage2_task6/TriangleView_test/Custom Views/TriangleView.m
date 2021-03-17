//
//  TriangleView.m
//  TriangleView_test
//
//  Created by worker on 20/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import "TriangleView.h"
#import "UIColor+ColorExtension.h"

@implementation TriangleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self startAnimationForTriangle:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGContextMoveToPoint(context, rect.size.width / 2.0, rect.origin.y);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x, rect.size.height);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [[UIColor hex:@"0x34C1A1"] CGColor]);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    
}

- (void) startAnimationForTriangle:(BOOL)flag {
    
    if (flag == YES) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            [self startAnimationForTriangle:NO];
        }];
    } else {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.transform = CGAffineTransformMakeRotation(2*M_PI);
        } completion:^(BOOL finished) {
            [self startAnimationForTriangle:YES];
        }];
    }
}

@end

