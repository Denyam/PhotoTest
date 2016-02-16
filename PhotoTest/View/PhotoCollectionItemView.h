//
//  PhotoCollectionItemView.h
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

@import Cocoa;

@class PhotoCollectionItemView;

@protocol PhotoCollectionItemViewDelegate <NSObject>
- (void)photoCollectionItemViewDidReceiveDoubleClick:(PhotoCollectionItemView *)view;
@end


@interface PhotoCollectionItemView : NSView

@property (nonatomic, weak) IBOutlet id <PhotoCollectionItemViewDelegate> delegate;

@end
