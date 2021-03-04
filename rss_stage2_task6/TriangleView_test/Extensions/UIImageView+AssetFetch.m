//
//  UIImageView+AssetFetch.m
//  TriangleView_test
//
//  Created by worker on 20.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import "UIImageView+AssetFetch.h"

@implementation UIImageView (AssetFetch)

- (void)fetchImageWithAsset:(PHAsset *)asset contentMode:(PHImageContentMode)contentMode targetSize:(CGSize)targetSize deliveryMode:(PHImageRequestOptionsDeliveryMode)mode completionHandler:(void (^ _Nullable )(void))completion {
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.version = PHImageRequestOptionsVersionOriginal;
    options.deliveryMode = mode;
    [PHImageManager.defaultManager requestImageForAsset:asset
                                             targetSize:targetSize
                                            contentMode:contentMode
                                                options:options
                                          resultHandler:^(UIImage *result, NSDictionary *info) {
        self.image = result;
        if(completion) {
            completion();
        }
    }];
    
    
}


@end
