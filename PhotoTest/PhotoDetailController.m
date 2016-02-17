//
//  PhotoDetailController.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "PhotoDetailController.h"

#import "Photo.h"
#import "PhotoStore.h"

@import CoreImage;

@interface PhotoDetailController ()
@property (nonatomic) IBOutlet NSImageView *photoView;

- (void)updateImage;
@end

@implementation PhotoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
	
}

- (void)viewDidAppear {
	[super viewWillAppear];
	
	[self.view.window makeFirstResponder:self];
	[self updateImage];
}

- (void)viewWillDisappear {
	[super viewWillDisappear];
	
	[self.view.window makeFirstResponder:nil];
}

- (void)setPhoto:(Photo *)photo {
	if (photo != _photo) {
		_photo = photo;
		[self updateImage];
	}
}

- (BOOL)acceptsFirstResponder {
	return YES;
}

- (void)cancelOperation:(id)sender {
	[self dismissController:self];
}

- (IBAction)moveUp:(id)sender {
	Photo *previousPhoto = [[PhotoStore instance] previousPhotoBefore:self.photo];
	if (previousPhoto) {
		self.photo = previousPhoto;
	}
}

- (IBAction)moveDown:(id)sender {
	Photo *nextPhoto = [[PhotoStore instance] nextPhotoAfter:self.photo];
	if (nextPhoto) {
		self.photo = nextPhoto;
	}
}

- (IBAction)blur:(id)sender {
	[self.photo getImageWithCompletion:^(NSImage *originalImage) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			CIImage *inputImage = [CIImage imageWithData:originalImage.TIFFRepresentation];
			CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
			[filter setDefaults];
			[filter setValue:inputImage forKey:kCIInputImageKey];
			CIImage *outputImage = [filter valueForKey:kCIOutputImageKey];
			
			NSRect outputRect = NSRectFromCGRect(outputImage.extent);
			NSImage *blurredImage = [NSImage imageWithSize:outputRect.size flipped:NO drawingHandler:^BOOL(NSRect dstRect) {
				[outputImage drawInRect:dstRect fromRect:dstRect operation:NSCompositeCopy fraction:1];
				
				return YES;
			}];
			
			dispatch_async(dispatch_get_main_queue(), ^{
				self.photoView.image = blurredImage;
			});
		});
	}];
}

- (void)updateImage {
	[self.photo getImageWithCompletion:^(NSImage *image) {
		self.photoView.image = image;
	}];
}

@end
