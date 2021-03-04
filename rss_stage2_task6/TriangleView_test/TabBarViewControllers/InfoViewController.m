//
//  InfoViewController.m
//  TriangleView_test
//
//  Created by worker on 20/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import "InfoViewController.h"
#import "CellInfo.h"
#import "ScrollViewController.h"

@interface InfoViewController () <PHPhotoLibraryChangeObserver>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) ScrollViewController* scrollViewController;
@property(strong, nonatomic) NSDateComponentsFormatter *formatter;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Info";
    
    self.tableView = [[UITableView alloc] init];
    [self configureFormatter];
    [self.view addSubview:self.tableView];
    [self setupConstraints];
    [self.tableView registerClass:[CellInfo class] forCellReuseIdentifier:@"cellId"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self makeAuth];
    
    [self.tableView reloadData];
}

- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void) setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
                        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]]];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)configureFormatter {
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    formatter.allowedUnits = (NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitHour);
    formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
    self.formatter = formatter;
}

- (void) makeAuth {
    __weak typeof(self) weakSelf = self;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (PHAuthorizationStatusAuthorized) {

            [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                PHFetchOptions *options = [[PHFetchOptions alloc] init];
                options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
                
                weakSelf.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            });
        } else {
            
        }
    }];
}

- (void) setupScrollViewController {
    
    self.scrollViewController = [[ScrollViewController alloc] init];
    self.scrollViewController.view.frame = self.navigationController.view.frame;
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//MARK: - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.assetsFetchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellInfo* cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    self.imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = self.assetsFetchResults[indexPath.row];
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    __weak typeof(cell) weakCell = cell;
    
     cell.imageRequestID = [self.imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info){
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
               weakCell.fileImageView.image = result;
               weakCell.fileNameLabel.text = [asset valueForKey:@"filename"];
             }
         });
     }];
        
    switch (asset.mediaType) {
        case PHAssetMediaTypeUnknown: {
            cell.fileThumbnailImageView.image = [UIImage imageNamed:@"other"];
            cell.fileImageView.image = [UIImage imageNamed:@"icons8-minus-128"];
            cell.fileSizeLabel.text = @"";
            break;
        }
        case PHAssetMediaTypeImage: {
            cell.fileThumbnailImageView.image = [UIImage imageNamed:@"image"];
            cell.fileSizeLabel.text = [NSString stringWithFormat:@"%lux%lu",(unsigned long)asset.pixelWidth, asset.pixelHeight];
            break;
        }
        case PHAssetMediaTypeVideo: {
            cell.fileThumbnailImageView.image = [UIImage imageNamed:@"video"];
            cell.fileSizeLabel.text = [NSString stringWithFormat:@"%lux%lu %@",(unsigned long)asset.pixelWidth, asset.pixelHeight, [self.formatter stringFromTimeInterval:asset.duration]];
            break;
        }
        case PHAssetMediaTypeAudio: {
            cell.fileThumbnailImageView.image = [UIImage imageNamed:@"audio"];
            cell.fileImageView.image = [UIImage imageNamed:@"icons8-musical-100"];
            cell.fileSizeLabel.text = [NSString stringWithFormat:@"%@", [self.formatter stringFromTimeInterval:asset.duration]];
            break;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.scrollViewController = [[ScrollViewController alloc] initWithAsset:self.assetsFetchResults[indexPath.row]];
    self.scrollViewController.view.frame = self.navigationController.view.frame;
    [self.navigationController pushViewController:self.scrollViewController animated:YES];
}

#pragma mark - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
    
    PHFetchResultChangeDetails *tableChanges = [changeInstance changeDetailsForFetchResult:self.assetsFetchResults];
    if (tableChanges == nil) {
        return;
    }
    
    //Change notifications may be made on a background queue. Re-dispatch to the main queue before acting on the change as we'll be updating the UI.
    dispatch_async(dispatch_get_main_queue(), ^{

        self.assetsFetchResults = [tableChanges fetchResultAfterChanges];
        
        UITableView *tableView = self.tableView;
        
        if (![tableChanges hasIncrementalChanges] || [tableChanges hasMoves]) {
           
            [tableView reloadData];
            
        } else {
           
            if (@available(iOS 11.0, *)) {
                [tableView performBatchUpdates:^{
                    NSIndexSet *removedIndexes = [tableChanges removedIndexes];
                    if ([removedIndexes count] > 0) {
                        [tableView deleteRowsAtIndexPaths:[self indexPathsFromIndexSet:removedIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    
                    NSIndexSet *insertedIndexes = [tableChanges insertedIndexes];
                    if ([insertedIndexes count] > 0) {
                        [tableView insertRowsAtIndexPaths:[self indexPathsFromIndexSet:insertedIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    
                    NSIndexSet *changedIndexes = [tableChanges changedIndexes];
                    if ([changedIndexes count] > 0) {
                        [tableView reloadRowsAtIndexPaths:[self indexPathsFromIndexSet:changedIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                } completion:NULL];
            } else {
                // Fallback on earlier versions
                NSIndexSet *removedIndexes = [tableChanges removedIndexes];
                if ([removedIndexes count] > 0) {
                    [tableView deleteRowsAtIndexPaths:[self indexPathsFromIndexSet:removedIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                
                NSIndexSet *insertedIndexes = [tableChanges insertedIndexes];
                if ([insertedIndexes count] > 0) {
                    [tableView insertRowsAtIndexPaths:[self indexPathsFromIndexSet:insertedIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                
                NSIndexSet *changedIndexes = [tableChanges changedIndexes];
                if ([changedIndexes count] > 0) {
                    [tableView reloadRowsAtIndexPaths:[self indexPathsFromIndexSet:changedIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        }
    });
}


- (NSArray *)indexPathsFromIndexSet:(NSIndexSet *)indexSet {
    NSMutableArray *paths = [[NSMutableArray alloc] init];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
        [paths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    }];
    return paths;
}

@end
