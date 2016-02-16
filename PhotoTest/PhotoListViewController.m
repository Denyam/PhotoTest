//
//  PhotoListViewController.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "PhotoListViewController.h"

#import "PhotosCollectionDataSource.h"
#import "PhotoDetailController.h"
#import "ReplacePresentationAnimator.h"
#import "Photo.h"

static NSString *const kShowPhotoDetailSegueId = @"showPhotoDetail";

@interface PhotoListViewController () <PhotoCollectionItemDelegate>
@property (nonatomic) id <PhotosCollectionDataSource> dataSource;

@property (nonatomic) IBOutlet NSCollectionView *collectionView;
@end


@implementation PhotoListViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.collectionView registerForDraggedTypes:@[NSFilenamesPboardType]];
	self.collectionView.dataSource = self.dataSource;
	self.collectionView.delegate = self.dataSource;
	[self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:kPhotoCollectionItemId bundle:nil] forItemWithIdentifier:kPhotoCollectionItemId];
}

/*
- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
	if ([segue.destinationController isKindOfClass:[PhotoDetailController class]] && [sender isKindOfClass:[Photo class]]) {
		PhotoDetailController *destinationController = segue.destinationController;
		destinationController.photo = sender;
	}
}
 */

- (id <NSCollectionViewDelegate>)dataSource {
	if (!_dataSource) {
		_dataSource = [PhotosCollectionDataSource new];
		_dataSource.photoListController = self;
	}
	return _dataSource;
}

- (void)showDetailFromPhotoCollectionItem:(PhotoCollectionItem *)item {
	id representedObject = item.representedObject;
	if ([representedObject isKindOfClass:[Photo class]]) {
		PhotoDetailController *detailController = [[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:NSStringFromClass([PhotoDetailController class])];
		detailController.photo = representedObject;
		[self presentViewController:detailController animator:[ReplacePresentationAnimator new]];
	}
}

@end
