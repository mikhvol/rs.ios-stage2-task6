//
//  CircleView.m
//  TriangleView_test
//
//  Created by worker on 19.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import "CircleView.h"
#import "UIColor+ColorExtension.h"

@implementation CircleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
        [self startAnimationForCircle:YES];
    }
    return self;
}

- (void) setupView {
    self.layer.cornerRadius = 35;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor hex:@"0xEE686A"];
}

- (void) startAnimationForCircle:(BOOL)flag {
    
    if (flag == YES) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }
                         completion:^(BOOL finished){
            [self startAnimationForCircle:NO];
        }];
    } else {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }
                         completion:^(BOOL finished){
            [self startAnimationForCircle:YES];
        }];
    }
}

@end
