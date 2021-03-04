//
//  ModalImageController.h
//  TriangleView_test
//
//  Created by worker on 20.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModalImageController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, copy) void(^ _Nullable completion)(void);

- (instancetype)initWithAsset:(PHAsset *)asset;

@end

NS_ASSUME_NONNULL_END
