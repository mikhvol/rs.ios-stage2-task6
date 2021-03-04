//
//  ScrollViewController.h
//  TriangleView_test
//
//  Created by worker on 25/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface ScrollViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) PHAsset* asset;

-(instancetype)initWithAsset:(PHAsset*)asset;

@end
