//
//  CellInfo.h
//  TriangleView_test
//
//  Created by worker on 24/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface CellInfo : UITableViewCell

@property (strong, nonatomic) UIImageView* fileImageView;
@property (strong, nonatomic) UIImageView* fileThumbnailImageView;
@property (strong, nonatomic) UILabel* fileNameLabel;
@property (strong, nonatomic) UILabel* fileSizeLabel;
@property (assign, nonatomic) PHImageRequestID imageRequestID;
@property (assign, nonatomic) PHContentEditingInputRequestID contentRequestID;
@property (copy, nonatomic) NSString *representedAssetIdentifier;


@end
