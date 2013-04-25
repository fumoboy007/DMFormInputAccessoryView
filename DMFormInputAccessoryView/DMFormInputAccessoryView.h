//
//  DMFormInputAccessoryView.h
//  DMFormInputAccessoryView
//
//  Created by Darren Mo on 2013-04-22.
//  Copyright (c) 2013 Darren Mo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DMFormInputAccessoryView;


@protocol DMFormInputAccessoryViewDataSource <NSObject>

- (UIResponder *)previousResponderForFormInputAccessoryView:(DMFormInputAccessoryView *)formInputAccessoryView;
- (UIResponder *)nextResponderForFormInputAccessoryView:(DMFormInputAccessoryView *)formInputAccessoryView;

@end


@interface DMFormInputAccessoryView : UIToolbar

@property (weak, nonatomic) UIResponder *attachedResponder;

@property (weak, nonatomic) id <DMFormInputAccessoryViewDataSource> dataSource;

- (void)reloadData;

@end
