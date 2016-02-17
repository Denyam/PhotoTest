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
@property (nonatomic) NSImage *image;
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
	if (self.image) {
		if (completion) {
			completion(self.image);
		}
	} else {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			self.image = [[NSImage alloc] initWithContentsOfFile:self.path];
			
			if (completion) {
				dispatch_async(dispatch_get_main_queue(), ^{
					completion(self.image);
				});
			}
		});
	}
}

@end
