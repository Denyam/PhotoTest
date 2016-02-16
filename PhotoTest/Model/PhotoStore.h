//
//  PhotoStore.h
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

@import Foundation;

@class Photo;

@interface PhotoStore : NSObject

+ (instancetype)instance;

@property (nonatomic, readonly) NSArray<Photo *> *photos;

- (void)addPhotoWithPath:(NSString *)path;

- (Photo *)nextPhotoAfter:(Photo *)photo;
- (Photo *)previousPhotoBefore:(Photo *)photo;

@end
