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

@interface PhotoDetailController ()
@property (nonatomic) IBOutlet NSImageView *photoView;
@end

@implementation PhotoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
	
}

- (void)viewDidAppear {
	[super viewWillAppear];
	
	[self.view.window makeFirstResponder:self];
	self.photoView.image = self.photo.image;
}

- (void)viewWillDisappear {
	[super viewWillDisappear];
	
	[self.view.window makeFirstResponder:nil];
}

- (void)setPhoto:(Photo *)photo {
	if (photo != _photo) {
		_photo = photo;
		self.photoView.image = _photo.image;
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

@end
