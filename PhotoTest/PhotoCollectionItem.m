//
//  PhotoCollectionItem.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "PhotoCollectionItem.h"

#import "PhotoCollectionItemView.h"

@interface PhotoCollectionItem () <PhotoCollectionItemViewDelegate>

@end

@implementation PhotoCollectionItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)photoCollectionItemViewDidReceiveDoubleClick:(PhotoCollectionItemView *)view {
	[self.delegate showDetailFromPhotoCollectionItem:self];
}

@end
