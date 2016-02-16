//
//  Photo.h
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

@import Foundation;

@interface Photo : NSObject

- (instancetype)initWithPath:(NSString *)path;

@property (nonatomic, readonly) NSString *path;
@property (nonatomic, readonly) NSImage *image;

@end
