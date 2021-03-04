//
//  GalleryCollectionViewCell.m
//  TriangleView_test
//
//  Created by worker on 19.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import "GalleryCollectionViewCell.h"

@implementation GalleryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
    
    self.fileImageView = [[UIImageView alloc] init];
    self.fileImageView.image = [UIImage imageNamed:@"apple.pdf"];
    self.fileImageView.translatesAutoresizingMaskIntoConstraints = false;
    self.fileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.fileImageView.clipsToBounds = YES;
    [self addSubview:self.fileImageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.fileImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.fileImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.fileImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.fileImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    ]];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.fileImageView.image = nil;
}

@end
