//
//  NSDate+StringFormat.h
//  TriangleView_test
//
//  Created by worker on 14.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (StringFormat)
- (NSString *)withFormat:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
