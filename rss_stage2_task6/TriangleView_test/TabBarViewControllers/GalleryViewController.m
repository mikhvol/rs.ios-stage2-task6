//
//  GalleryViewController.m
//  TriangleView_test
//
//  Created by worker on 20/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryCollectionViewCell.h"
#import "PlayerController.h"
#import "ModalImageController.h"

@interface GalleryViewController () <PHPhotoLibraryChangeObserver>

@property (strong, nonatomic) UICollectionView* galleryCollectionView;

@end

@implementation GalleryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.galleryCollectionView.collectionViewLayout invalidateLayout];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.galleryCollectionView.collectionViewLayout invalidateLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Gallery";
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.galleryCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.galleryCollectionView setDataSource:self];
    [self.galleryCollectionView setDelegate:self];
    [self.galleryCollectionView registerClass:[GalleryCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.galleryCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.galleryCollectionView];
    [self getDataWithAuth];
    [self.galleryCollectionView reloadData];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) getDataWithAuth {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (PHAuthorizationStatusAuthorized) {
            [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self fetchData];
            });
        }
    }];
}

- (void)dealloc {
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GalleryCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    self.imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    __weak typeof(cell) weakCell = cell;
    cell.imageRequestID = [self.imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info){
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                weakCell.fileImageView.image = result;
            }
        });
    }];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsFetchResults.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (((PHAsset *) self.assetsFetchResults[indexPath.item]).mediaType) {
        case PHAssetMediaTypeVideo: {
            [PHCachingImageManager.defaultManager requestAVAssetForVideo:self.assetsFetchResults[indexPath.item]
                                                                 options:0
                                                           resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    AVPlayer *player = [AVPlayer playerWithURL: urlAsset.URL];
                    PlayerController *vc = [PlayerController new];
                    vc.player = player;
                    vc.modalPresentationCapturesStatusBarAppearance = YES;
                    [self presentViewController:vc animated:YES completion:^{
                    }];
                });
            }];
            break;
        }
        case PHAssetMediaTypeImage: {
            ModalImageController *vc = [[ModalImageController alloc] initWithAsset:self.assetsFetchResults[indexPath.item]];
            vc.completion = ^{
                [self.galleryCollectionView.collectionViewLayout invalidateLayout];
            };
            vc.modalPresentationCapturesStatusBarAppearance = YES;
            [self presentViewController:vc animated:YES completion:nil];
            break;
        }
        default: {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                        message:@"Can't show this :("
                                                                 preferredStyle:UIAlertControllerStyleAlert];
            vc.modalPresentationCapturesStatusBarAppearance = YES;
            [vc addAction:[UIAlertAction actionWithTitle:@"ok"
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil]];
            [self presentViewController:vc
                               animated:YES
                             completion:nil];
            break;
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat edgeSize = (self.galleryCollectionView.frame.size.width - 16) / 3;
    return CGSizeMake(edgeSize, edgeSize);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  UIEdgeInsetsMake(5, 4, 4, 4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0;
}

//MARK: - Fetching Data

- (void)fetchData {
    PHFetchOptions *options = [PHFetchOptions new];
    options.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate"
                                                            ascending:YES]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.galleryCollectionView reloadData];
    });
}

//MARK: - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    [self fetchData];
}

@end
