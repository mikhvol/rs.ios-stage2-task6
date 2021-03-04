//
//  UIImageView+AssetFetch.h
//  TriangleView_test
//
//  Created by worker on 20.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (AssetFetch)

- (void)fetchImageWithAsset:(PHAsset *)asset contentMode:(PHImageContentMode)contentMode targetSize:(CGSize)targetSize deliveryMode:(PHImageRequestOptionsDeliveryMode)mode completionHandler:(void (^ _Nullable )(void))completion;

@end

NS_ASSUME_NONNULL_END
