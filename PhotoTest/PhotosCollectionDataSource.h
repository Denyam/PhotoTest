//
//  PhotosCollectionDataSource.h
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

@import Cocoa;

@class PhotoListViewController;
@protocol PhotoCollectionItemDelegate;

extern NSString *const kPhotoCollectionItemId;

@protocol PhotosCollectionDataSource <NSCollectionViewDataSource, NSCollectionViewDelegate>
@property (nonatomic, weak) PhotoListViewController<PhotoCollectionItemDelegate> *photoListController;
@end


@interface PhotosCollectionDataSource : NSObject <PhotosCollectionDataSource>
@end
