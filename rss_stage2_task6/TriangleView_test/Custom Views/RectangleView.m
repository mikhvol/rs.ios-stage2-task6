//
//  RectangleView.m
//  TriangleView_test
//
//  Created by worker on 20.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import "RectangleView.h"
#import "UIColor+ColorExtension.h"

@implementation RectangleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
        [self startAnimationForRectangle:YES];
    }
    return self;
}

- (void) setupView {
    self.frame = CGRectMake(0, 0, 70, 70);
    self.backgroundColor = [UIColor hex:@"0x29C2D1"];
}

- (void) startAnimationForRectangle:(BOOL)flag {
    
    if (flag == YES) {
        [UIView animateWithDuration:1.0 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0.0, self.frame.size.width * 0.1);
        }
                         completion:^(BOOL finished){
                             [self startAnimationForRectangle:NO];
                         }];
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0.0, self.frame.size.width * (-0.1));
        }
                         completion:^(BOOL finished){
                             [self startAnimationForRectangle:YES];
                         }];
    }
}

@end
