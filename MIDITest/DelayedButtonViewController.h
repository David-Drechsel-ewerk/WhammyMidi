//
//  DelayedButtonViewController.h
//  MIDITest
//
//  Created by David Drechsel on 27.03.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DelayedButtonViewController : UIViewController

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL btnFiredSelector;
@property (nonatomic, assign) NSTimeInterval delay;

@end
