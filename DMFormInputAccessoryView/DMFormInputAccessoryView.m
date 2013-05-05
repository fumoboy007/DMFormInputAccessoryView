// The MIT License (MIT)
//
// Copyright (c) 2013 Darren Mo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OfF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


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
