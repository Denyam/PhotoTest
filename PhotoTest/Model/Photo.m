//
//  Photo.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "Photo.h"

#import <AppKit/NSImage.h>

@implementation Photo

@synthesize path = _path;
@synthesize image = _image;

- (instancetype)initWithPath:(NSString *)path {
	if ((self = [self init])) {
		_path = path;
	}
	return self;
}

- (NSImage *)image {
	if (!_image) {
		_image = [[NSImage alloc] initWithContentsOfFile:self.path];
	}
	return _image;
}

@end
