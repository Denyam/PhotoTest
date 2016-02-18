//
//  PhotosCollectionDataSource.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "PhotosCollectionDataSource.h"

#import "PhotoStore.h"
#import "Photo.h"
#import "PhotoCollectionItem.h"

NSString *const kPhotoCollectionItemId = @"PhotoCollectionItem";

@implementation PhotosCollectionDataSource

@synthesize photoListController;

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [PhotoStore instance].photos.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
	PhotoCollectionItem *result = [collectionView makeItemWithIdentifier:kPhotoCollectionItemId forIndexPath:indexPath];
	
	result.delegate = self.photoListController;
	
	Photo *photo = [PhotoStore instance].photos[indexPath.item];
	result.representedObject = photo;
	
	NSSize size = [collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath].size;
	
	[photo getImageToFit:size withCompletion:^(NSImage *image) {
		result.imageView.image = image;
	}];
	
	return result;
}

#pragma mark - Drag

- (NSDragOperation)collectionView:(NSCollectionView *)collectionView validateDrop:(id<NSDraggingInfo>)draggingInfo proposedIndexPath:(NSIndexPath *__autoreleasing  _Nonnull *)proposedDropIndexPath dropOperation:(NSCollectionViewDropOperation *)proposedDropOperation {
	return draggingInfo.draggingSourceOperationMask;
}

- (BOOL)collectionView:(NSCollectionView *)collectionView acceptDrop:(id<NSDraggingInfo>)draggingInfo indexPath:(NSIndexPath *)indexPath dropOperation:(NSCollectionViewDropOperation)dropOperation {
	BOOL result = NO;
	
	NSPasteboard *pasteboard = draggingInfo.draggingPasteboard;
	if ([pasteboard availableTypeFromArray:@[NSFilenamesPboardType]]) {
		NSArray *filesList = [pasteboard propertyListForType:NSFilenamesPboardType];
		
		for (NSString *path in filesList) {
			[[PhotoStore instance] addPhotoWithPath:path];
		}
		
		result = YES;
		
		[collectionView reloadData];
	}
	
	return result;
}

@end
