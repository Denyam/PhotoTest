//
//  Photo.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "Photo.h"

#import <AppKit/NSImage.h>

@interface Photo ()
- (NSImage *)resizedImage:(NSImage *)image toFit:(NSSize)size;
@end


@implementation Photo

@synthesize path = _path;

- (instancetype)initWithPath:(NSString *)path {
	if ((self = [self init])) {
		_path = path;
	}
	return self;
}

- (void)getImageWithCompletion:(void (^)(NSImage *))completion {
	[self getImageToFit:NSZeroSize withCompletion:completion];
}

- (void)getImageToFit:(NSSize)size withCompletion:(void (^)(NSImage *))completion {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSImage *image = [[NSImage alloc] initWithContentsOfFile:self.path];
		image = [self resizedImage:image toFit:size];
		
		if (completion) {
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(image);
			});
		}
	});
}

- (NSImage *)resizedImage:(NSImage *)image toFit:(NSSize)size {
	NSImage *result = image;
	
	if ((size.width != 0) && (size.height != 0)) {
		NSSize originalSize = image.size;
		NSSize destinationSize = size;
		
		CGFloat sourceAspectRatio = originalSize.width / originalSize.height;
		CGFloat destinationAspectRatio = size.width / size.height;
		if (destinationAspectRatio > sourceAspectRatio) {
			destinationSize.width = size.height * sourceAspectRatio;
		} else if (destinationAspectRatio < sourceAspectRatio) {
			destinationSize.height = size.width / sourceAspectRatio;
		}
		
		if (destinationAspectRatio != sourceAspectRatio) {
			result = image.copy;
			result.size = destinationSize;
			[result lockFocus];
			[result unlockFocus];
		}
	}
	
	return result;
}

@end
