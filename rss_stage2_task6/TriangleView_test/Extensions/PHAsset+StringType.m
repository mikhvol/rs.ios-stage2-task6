//
//  PHAsset+StringType.m
//  TriangleView_test
//
//  Created by worker on 14.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import "PHAsset+StringType.h"

@implementation PHAsset (StringType)

- (NSString *)stringType {
    switch (self.mediaType) {
        case PHAssetMediaTypeAudio:
            return @"Audio";
        case PHAssetMediaTypeImage:
            return @"Image";
        case PHAssetMediaTypeVideo:
            return @"Video";
        default:
            return @"Other";
    }
}

- (NSString *)stringDuration {
    NSUInteger hours = lround(floor(self.duration / 3600.)) % 100;
    NSUInteger minutes = lround(floor(self.duration / 60.)) % 60;
    NSUInteger seconds = lround(floor(self.duration)) % 60;
    if(hours == 0) {
        return [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)minutes, (unsigned long)seconds];
    }
    return [NSString stringWithFormat:@"%02lu:%02lu:%02lu", (unsigned long)hours, (unsigned long)minutes, (unsigned long)seconds];
}

@end
