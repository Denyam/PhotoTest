//
//  PhotoCollectionItemView.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "PhotoCollectionItemView.h"

@implementation PhotoCollectionItemView

- (void)mouseDown:(NSEvent *)theEvent {
	if (theEvent.clickCount == 2) {
		[self.delegate photoCollectionItemViewDidReceiveDoubleClick:self];
	} else {
		[super mouseDown:theEvent];
	}
}

@end
