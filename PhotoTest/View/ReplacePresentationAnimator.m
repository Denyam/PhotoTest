//
//  ReplacePresentationAnimator.m
//  PhotoTest
//
//  Created by Denis on 16/02/2016.
//  Copyright © 2016 Denis. All rights reserved.
//

#import "ReplacePresentationAnimator.h"

@implementation ReplacePresentationAnimator

- (void)animatePresentationOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
		fromViewController.view.animator.alphaValue = 0;
	} completionHandler:^{
		viewController.view.alphaValue = 0;
		fromViewController.view.window.contentViewController = viewController;
		viewController.view.animator.alphaValue = 1;
	}];
}

- (void)animateDismissalOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
		viewController.view.animator.alphaValue = 0;
	} completionHandler:^{
		fromViewController.view.alphaValue = 0;
		viewController.view.window.contentViewController = fromViewController;
		fromViewController.view.animator.alphaValue = 1;
	}];
}

@end
