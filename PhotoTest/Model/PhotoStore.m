//
//  PhotoStore.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "PhotoStore.h"

#import "Photo.h"

@interface PhotoStore ()
@property (nonatomic) NSMutableArray<Photo *> *mutablePhotos;
@end

@implementation PhotoStore

+ (instancetype)instance {
	static PhotoStore *sPhotoStoreInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sPhotoStoreInstance = [PhotoStore new];
	});
	return sPhotoStoreInstance;
}

- (void)addPhotoWithPath:(NSString *)path {
	if (path) {
		Photo *photo = [[Photo alloc] initWithPath:path];
		[self.mutablePhotos addObject:photo];
	}
}

- (NSMutableArray<Photo *> *)mutablePhotos {
	if (!_mutablePhotos) {
		_mutablePhotos = [NSMutableArray new];
	}
	return _mutablePhotos;
}

- (NSArray<Photo *> *)photos {
	return _mutablePhotos;
}

- (Photo *)nextPhotoAfter:(Photo *)photo {
	Photo *result = nil;
	
	NSUInteger currentIndex = [self.photos indexOfObject:photo];
	if (currentIndex < self.photos.count - 1) {
		result = self.photos[currentIndex + 1];
	}
	
	return result;
}

- (Photo *)previousPhotoBefore:(Photo *)photo {
	Photo *result = nil;
	
	NSUInteger currentIndex = [self.photos indexOfObject:photo];
	if ((currentIndex > 0) && (currentIndex < self.photos.count)) {
		result = self.photos[currentIndex - 1];
	}
	
	return result;
}

@end
