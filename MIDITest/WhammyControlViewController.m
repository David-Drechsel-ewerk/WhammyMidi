//
//  WhammyControlViewController.m
//  MIDITest
//
//  Created by David Drechsel on 20.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//
//  Baseclass for all WhammyControls with touchinput
//
//  4 Finger Tap for Whammy On
//  3 Finger Tap for Whammy Off
//

#import "WhammyControlViewController.h"

@interface WhammyControlViewController ()

@end

@implementation WhammyControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *f2WhammyOff = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(whammyOff:)];
    f2WhammyOff.numberOfTouchesRequired = 2;
    f2WhammyOff.numberOfTapsRequired = 1;
  f2WhammyOff.delegate = self;
    //f2WhammyOff.delaysTouchesBegan = YES;
    [self.view addGestureRecognizer:f2WhammyOff];
    
    UITapGestureRecognizer *f3WhammyOn = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(whammyOn:)];
    f3WhammyOn.numberOfTouchesRequired = 3;
    f3WhammyOn.numberOfTapsRequired = 1;
  f3WhammyOn.delegate = self;
    //f3WhammyOn.delaysTouchesBegan = YES;
    [self.view addGestureRecognizer:f3WhammyOn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma gestureDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

#pragma mark gestures
-(void)whammyOff:(UIGestureRecognizer*)gesture
{
    [WhammyMidi whammyOff];
}

-(void)whammyOn:(UIGestureRecognizer*)gesture
{
    [WhammyMidi whammyOn];
}
@end
