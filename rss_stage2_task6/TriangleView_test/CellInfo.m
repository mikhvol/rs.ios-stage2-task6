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
    
    self.fileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x + 5, self.frame.origin.y + 2, 86, 86)];
    self.fileImageView.image = [UIImage imageNamed:@"apple.pdf"];
    self.fileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.fileImageView.clipsToBounds = YES;
    [self addSubview:self.fileImageView];
    
    self.fileNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.fileImageView.frame.size.width + 20, self.fileImageView.frame.origin.y + 17, 130, 20)];
    [self.fileNameLabel setFont:[UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]];
    self.fileNameLabel.text = @"name_file.jpg";
    [self addSubview:self.fileNameLabel];
    
    self.fileThumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.fileNameLabel.frame.origin.x, self.fileNameLabel.frame.size.height + 33, 15, 20)];
    self.fileThumbnailImageView.image = [UIImage imageNamed:@"other.pdf"];
    [self addSubview:self.fileThumbnailImageView];
    
    self.fileSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake( self.fileThumbnailImageView.frame.origin.x + self.fileThumbnailImageView.frame.size.width + 5, self.fileThumbnailImageView.frame.origin.y + 2.5, 150, 15)];
    [self.fileSizeLabel setFont:[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular]];
    self.fileSizeLabel.text = @"9999x9999";
    [self addSubview:self.fileSizeLabel];
    
}
@end
