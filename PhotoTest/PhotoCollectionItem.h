//
//  PhotoCollectionItem.h
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

@import Cocoa;

@class PhotoCollectionItem;

@protocol PhotoCollectionItemDelegate <NSObject>
- (void)showDetailFromPhotoCollectionItem:(PhotoCollectionItem *)item;
@end

@interface PhotoCollectionItem : NSCollectionViewItem
@property (nonatomic, weak) id <PhotoCollectionItemDelegate> delegate;
@end
