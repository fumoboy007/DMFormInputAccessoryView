//
//  DMFormInputAccessoryView.m
//  DMFormInputAccessoryView
//
//  Created by Darren Mo on 2013-04-22.
//  Copyright (c) 2013 Darren Mo. All rights reserved.
//

#import "DMFormInputAccessoryView.h"


typedef NS_ENUM(NSUInteger, PrevNextSegment) {
	PrevSegment = 0,
	NextSegment
};


@implementation DMFormInputAccessoryView {
	UISegmentedControl *_prevNextSegmentedControl;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		self.barStyle = UIBarStyleBlack;
		self.translucent = YES;
		
		
		_prevNextSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Previous", @"Next"]];
		
		_prevNextSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
		_prevNextSegmentedControl.momentary = YES;
		
		[_prevNextSegmentedControl addTarget:self action:@selector(prevNextSegmentedControlValueChanged) forControlEvents:UIControlEventValueChanged];
		
		UIBarButtonItem *prevNextBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_prevNextSegmentedControl];
		
		
		UIBarButtonItem *flexibleSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		
		
		UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBarButtonPressed)];
		
		
		self.items = @[prevNextBarButtonItem, flexibleSpaceBarButtonItem, doneBarButtonItem];
		
		
		[self sizeToFit];
	}
	
	return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
	[super willMoveToWindow:newWindow];
	
	if (newWindow)
		[self configurePrevNextSegmentedControl];
}

#pragma mark - Configuring the segmented control

- (void)configurePrevNextSegmentedControl {
	BOOL prevEnabled = [_dataSource previousResponderForFormInputAccessoryView:self] != nil;
	BOOL nextEnabled = [_dataSource nextResponderForFormInputAccessoryView:self] != nil;
	
	[_prevNextSegmentedControl setEnabled:prevEnabled forSegmentAtIndex:PrevSegment];
	[_prevNextSegmentedControl setEnabled:nextEnabled forSegmentAtIndex:NextSegment];
}

#pragma mark - Handling segmented control value changes

- (void)prevNextSegmentedControlValueChanged {
	switch (_prevNextSegmentedControl.selectedSegmentIndex) {
		case PrevSegment:
		{
			UIResponder *previousResponder = [_dataSource previousResponderForFormInputAccessoryView:self];
			
			[previousResponder becomeFirstResponder];
		}
			break;
			
		case NextSegment:
		{
			UIResponder *nextResponder = [_dataSource nextResponderForFormInputAccessoryView:self];
			
			[nextResponder becomeFirstResponder];
		}
			break;
			
		default:
			break;
	}
	
	[self configurePrevNextSegmentedControl];
}

#pragma mark - Done pressed

- (void)doneBarButtonPressed {
	[_attachedResponder resignFirstResponder];
}

#pragma mark - Reloading data

- (void)reloadData {
	[self configurePrevNextSegmentedControl];
}

@end
