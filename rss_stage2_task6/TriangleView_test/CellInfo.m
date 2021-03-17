//
//  CellInfo.m
//  TriangleView_test
//
//  Created by worker on 24/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import "CellInfo.h"

@implementation CellInfo

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setupViews {
    self.fileImageView = [[UIImageView alloc] init];
    self.fileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileImageView.image = [UIImage imageNamed:@"apple.pdf"];
    self.fileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.fileImageView.clipsToBounds = YES;
    [self addSubview:self.fileImageView];
    
    self.fileNameLabel = [[UILabel alloc] init];
    self.fileNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileNameLabel.adjustsFontSizeToFitWidth = YES;
    [self.fileNameLabel setFont:[UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]];
    self.fileNameLabel.text = @"name_file.jpg";
    [self addSubview:self.fileNameLabel];
    
    self.fileThumbnailImageView = [[UIImageView alloc] init];
    self.fileThumbnailImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileThumbnailImageView.image = [UIImage imageNamed:@"other.pdf"];
    [self addSubview:self.fileThumbnailImageView];
    
    self.fileSizeLabel = [[UILabel alloc] init];
    self.fileSizeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileSizeLabel.adjustsFontSizeToFitWidth = YES;
    [self.fileSizeLabel setFont:[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular]];
    self.fileSizeLabel.text = @"9999x9999";
    [self addSubview:self.fileSizeLabel];
}

- (void) setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.fileImageView.heightAnchor constraintEqualToConstant:86],
        [self.fileImageView.widthAnchor constraintEqualToConstant:86],
        [self.fileImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:2],
        [self.fileImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
        [self.fileNameLabel.heightAnchor constraintEqualToConstant:20],
        [self.fileNameLabel.widthAnchor constraintEqualToConstant:150],
        [self.fileNameLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
        [self.fileNameLabel.leadingAnchor constraintEqualToAnchor:self.fileImageView.trailingAnchor constant:30],
        [self.fileThumbnailImageView.heightAnchor constraintEqualToConstant:20],
        [self.fileThumbnailImageView.widthAnchor constraintEqualToConstant:15],
        [self.fileThumbnailImageView.topAnchor constraintEqualToAnchor:self.fileNameLabel.bottomAnchor constant:20],
        [self.fileThumbnailImageView.leadingAnchor constraintEqualToAnchor:self.fileImageView.trailingAnchor constant:40],
        [self.fileSizeLabel.heightAnchor constraintEqualToConstant:20],
        [self.fileSizeLabel.widthAnchor constraintEqualToConstant:100],
        [self.fileSizeLabel.topAnchor constraintEqualToAnchor:self.fileNameLabel.bottomAnchor constant:20],
        [self.fileSizeLabel.leadingAnchor constraintEqualToAnchor:self.fileThumbnailImageView.trailingAnchor constant:10]
    ]];
}

@end
