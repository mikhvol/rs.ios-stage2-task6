//
//  NSDate+StringFormat.m
//  TriangleView_test
//
//  Created by worker on 14.02.2021.
//  Copyright © 2021 Mike Volkov. All rights reserved.
//

#import "NSDate+StringFormat.h"

@implementation NSDate (StringFormat)
- (NSString *)withFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    NSString *result = [formatter stringFromDate:self];
    return result;
}
@end
