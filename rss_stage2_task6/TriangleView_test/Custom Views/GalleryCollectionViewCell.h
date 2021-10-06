//
//  GalleryCollectionViewCell.h
//  TriangleView_test
//
//  Created by worker on 19.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView* fileImageView;
@property (assign, nonatomic) PHImageRequestID imageRequestID;
@property (copy, nonatomic) NSString *representedAssetIdentifier;

@end

NS_ASSUME_NONNULL_END
