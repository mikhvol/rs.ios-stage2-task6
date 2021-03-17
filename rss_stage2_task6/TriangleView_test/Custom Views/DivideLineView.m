//
//  DivideLineView.m
//  TriangleView_test
//
//  Created by worker on 04.03.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import "DivideLineView.h"
#import "UIColor+ColorExtension.h"

@implementation DivideLineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void) setupView {
    self.layer.cornerRadius = 2;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor lightGrayColor];
    self.alpha = 0.4;
}

@end
