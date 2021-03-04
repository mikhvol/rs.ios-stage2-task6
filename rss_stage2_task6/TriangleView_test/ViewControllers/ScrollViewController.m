//
//  ScrollViewController.m
//  TriangleView_test
//
//  Created by worker on 25/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import "ScrollViewController.h"
#import "UIColor+ColorExtension.h"
#import "NSDate+StringFormat.h"
#import "PHAsset+StringType.h"

@interface ScrollViewController ()

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UIImageView* fileImageView;
@property (strong, nonatomic) UIButton* activityButton;
@property (strong, nonatomic) UILabel* creationDateLabel;
@property (strong, nonatomic) UILabel* modificationDateLabel;
@property (strong, nonatomic) UILabel* typeLabel;

@end

@implementation ScrollViewController

- (instancetype)initWithAsset:(PHAsset *)asset
{
    self = [super init];
    if (self) {
        _asset = asset;
        self.hidesBottomBarWhenPushed = TRUE;
        self.navigationItem.title = [self.asset valueForKey:@"filename"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void) getImageFromAsset:(PHAsset*)asset {
    PHCachingImageManager* imageManager = [[PHCachingImageManager alloc] init];
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.version = PHImageRequestOptionsVersionOriginal;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    
    [imageManager requestImageForAsset:self.asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.fileImageView.image = result;
    }];
}

- (void) setupViews {
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.backgroundColor = [UIColor hex:@"0xFFFFFF"];
    [self.view addSubview:self.scrollView];

    self.fileImageView = [[UIImageView alloc] init];
    self.fileImageView.frame = CGRectMake(self.scrollView.frame.origin.x + 15, self.scrollView.frame.origin.y + 15, self.scrollView.frame.size.width - 30, self.scrollView.frame.size.width - 30);
    self.fileImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self getImageFromAsset:self.asset];
    self.scrollView.contentSize = self.scrollView.bounds.size;
    [self.scrollView addSubview:self.fileImageView];
    
    self.creationDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.fileImageView.frame.origin.x, self.fileImageView.bounds.size.height + self.fileImageView.frame.origin.y + 30, 350, 20)];
    self.creationDateLabel.text = [NSString stringWithFormat:@"Creation date: %@", [self.asset.creationDate withFormat:@"HH:mm:ss dd.MM.yyyy"]];
    [self.creationDateLabel setFont:[UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]];
    [self.creationDateLabel setTextColor:[UIColor hex:@"0x707070"]];
    [self.scrollView addSubview:self.creationDateLabel];
    
    self.modificationDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.creationDateLabel.frame.origin.x, self.creationDateLabel.bounds.size.height + self.creationDateLabel.frame.origin.y + 10, 350, 20)];
    self.modificationDateLabel.text = [NSString stringWithFormat:@"Modification date: %@", [self.asset.modificationDate withFormat:@"HH:mm:ss dd.MM.yyyy"]];
    [self.modificationDateLabel setFont:[UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]];
    [self.modificationDateLabel setTextColor:[UIColor hex:@"0x707070"]];
    [self.scrollView addSubview:self.modificationDateLabel];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.modificationDateLabel.frame.origin.x, self.modificationDateLabel.bounds.size.height + self.modificationDateLabel.frame.origin.y + 10, 250, 20)];
    self.typeLabel.text = [NSString stringWithFormat:@"Type: %@", [self.asset stringType]];
    [self.typeLabel setFont:[UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]];
    [self.typeLabel setTextColor:[UIColor hex:@"0x707070"]];
    [self.scrollView addSubview:self.typeLabel];
    
    self.activityButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width * 0.75, 55)];
    self.activityButton.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y * 1.65);
    self.activityButton.backgroundColor = [UIColor hex:@"0xF9CC78"];
    self.activityButton.layer.cornerRadius = 27.5;
    self.activityButton.clipsToBounds = YES;
    [self.activityButton setTitle:@"Share" forState:UIControlStateNormal];
    [self.activityButton setTitleColor:[UIColor hex:@"0x101010"] forState:UIControlStateNormal];
    [self.activityButton.titleLabel setFont:[UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium]];
    [self.activityButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.activityButton];
}

- (void) share {
    switch (self.asset.mediaType) {
        case PHAssetMediaTypeImage: {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.synchronous = YES;
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            options.resizeMode = PHImageRequestOptionsResizeModeNone;
            
            [PHImageManager.defaultManager requestImageDataForAsset:self.asset
                                                            options:options
                                                      resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                [self presentActivityWith:imageData];
            }];
            break;
        }
        case PHAssetMediaTypeVideo: {
            [PHCachingImageManager.defaultManager requestAVAssetForVideo:self.asset
                                                                 options:0
                                                           resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                [self presentActivityWith:urlAsset.URL];
            }];
            break;
        }
        default: {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                        message:@"Can't share this media"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"Back"
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

- (void) presentActivityWith:(NSObject*) data{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[data] applicationActivities:@[]];
        
        vc.popoverPresentationController.sourceView = self.view;
        vc.popoverPresentationController.sourceRect = CGRectMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.height / 2, 0, 0);
        vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        [self presentViewController:vc animated:YES completion:nil];
    });
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
// MARK: - UIScrollViewDelegate

@end
