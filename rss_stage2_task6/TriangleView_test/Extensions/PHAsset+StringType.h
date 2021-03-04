//
//  PHAsset+StringType.h
//  TriangleView_test
//
//  Created by worker on 14.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (StringType)

- (NSString *)stringType;
- (NSString *)stringDuration;

@end

NS_ASSUME_NONNULL_END
