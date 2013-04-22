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
#import "MenuViewController.h"
#import "MTInfoPanel.h"
#import "MFSideMenu.h"

@interface WhammyControlViewController ()
{
  NSMutableArray *touchesInView;
  NSTimer *delayTimer;
  BOOL handlesTouch;
}

@end

@implementation WhammyControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      touchTimerDelay = kTouchTimerDelay;
    }
    return self;
}

-(void)setupGestures
{
  //    UITapGestureRecognizer *f2WhammyOff = [[UITapGestureRecognizer alloc] initWithTarget:self
  //                                                                                  action:@selector(whammyOff:)];
  //    f2WhammyOff.numberOfTouchesRequired = 2;
  //    f2WhammyOff.numberOfTapsRequired = 1;
  //    f2WhammyOff.delegate = self;
  //    f2WhammyOff.delaysTouchesBegan = YES;
  //    [self.view addGestureRecognizer:f2WhammyOff];
  //
  //    UITapGestureRecognizer *f3WhammyOn = [[UITapGestureRecognizer alloc] initWithTarget:self
  //                                                                                  action:@selector(whammyOn:)];
  //    f3WhammyOn.numberOfTouchesRequired = 3;
  //    f3WhammyOn.numberOfTapsRequired = 1;
  //    f3WhammyOn.delegate = self;
  //    f3WhammyOn.delaysTouchesBegan = YES;
  //    [self.view addGestureRecognizer:f3WhammyOn];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  touchesInView = [NSMutableArray array];
  [self setupGestures];
  
  //add Back Button
  DelayedButtonViewController *whammyOffbtn = [[DelayedButtonViewController alloc] initWithNibName:@"DelayedButtonViewController" bundle:nil];
  [self addChildViewController:whammyOffbtn];
  whammyOffbtn.delay = 0.3;
  whammyOffbtn.image = nil;
  whammyOffbtn.text = @"Off";
  whammyOffbtn.delegate = self;
  whammyOffbtn.btnFiredSelector = @selector(whammyOff:);
  [self.view addSubview:whammyOffbtn.view];
  whammyOffbtn.view.frame = CGRectMake(self.view.frame.size.width-47, 246, 44, 44);
  
  DelayedButtonViewController *backBtn = [[DelayedButtonViewController alloc] initWithNibName:@"DelayedButtonViewController" bundle:nil];
  [self addChildViewController:backBtn];
  backBtn.image = [UIImage imageNamed:@"menu-icon"];
  backBtn.delegate = self;
  backBtn.btnFiredSelector = @selector(back:);
  [self.view addSubview:backBtn.view];
  backBtn.view.frame = CGRectMake(self.view.frame.size.width-47, 10, 44, 44);
  
  DelayedButtonViewController *quickModeBtn = [[DelayedButtonViewController alloc] initWithNibName:@"DelayedButtonViewController" bundle:nil];
  [self addChildViewController:quickModeBtn];
  quickModeBtn.image = [UIImage imageNamed:@"fav"];
  quickModeBtn.delegate = self;
  quickModeBtn.btnFiredSelector = @selector(quickModeBtnPressed:);
  [self.view addSubview:quickModeBtn.view];
  quickModeBtn.view.frame = CGRectMake(3, 10, 44, 44);

  xyPad.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.3f];
  CALayer *layer = xyPad.layer;
  layer.cornerRadius = 8;
  layer.borderColor = kBaseColor.CGColor;
  layer.borderWidth = 2;
  //layer.shouldRasterize = YES;
  layer.masksToBounds = YES;
  
  CALayer *superlayer = xyPad.superview.layer;
  superlayer.shouldRasterize = YES;
  superlayer.shadowColor = [UIColor blackColor].CGColor;
  superlayer.shadowOffset = CGSizeZero;
  superlayer.shadowRadius = 3.0f;
  superlayer.shadowOpacity = 0.8f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark manualTouches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  if (handlesTouch)
  {
    //we are aleraedy tracking one touch and ignore all further touches
    return;
  }
  
  if (!delayTimer)
  {
    delayTimer = [NSTimer scheduledTimerWithTimeInterval:touchTimerDelay
                                                  target:self
                                                selector:@selector(handleButtonTouch)
                                                userInfo:nil
                                                 repeats:NO];
  }
  [touchesInView addObjectsFromArray:[touches allObjects]];
  [self checkTouches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  if (handlesTouch)
  {
    NSAssert([touchesInView count] == 1, @"handleSingleTouchMoved with != one recognized touch");
    UITouch *touch = [touchesInView objectAtIndex:0];
    [self singleFingerMoved:touch];
  }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [touchesInView removeObjectsInArray:[touches allObjects]];
  [delayTimer invalidate];
  delayTimer = nil;
  [self finishHandledTouch];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [touchesInView removeAllObjects];
  [delayTimer invalidate];
  delayTimer = nil;
  [self finishHandledTouch];
}

-(void)checkTouches
{
  if ([touchesInView count] > 1)
  {
    [delayTimer invalidate];
    delayTimer = nil;
  }
}

-(void)finishHandledTouch
{
  if (handlesTouch)
  {
    [self finishedHandleSingleTouch];
    
    handlesTouch = NO;
  }
}

-(void)handleButtonTouch
{
  //this method should only trigger if exactly one touch is recognized.
  NSAssert([touchesInView count] == 1, @"handleSingleTouch with != one recognized touch");
  UITouch *touch = [touchesInView objectAtIndex:0];
  handlesTouch = YES;
  [self singleFingerTouch:touch];
}

#pragma gestureDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

#pragma mark gestureDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  return !handlesTouch;
}

#pragma mark gestures
-(void)whammyOff:(UIGestureRecognizer*)gesture
{
  [WhammyMidi whammyOff];
  [MTInfoPanel showPanelInView:self.view type:MTInfoPanelTypeWarning title:@"Whammy Off" subtitle:nil hideAfter:0.6f];
}

-(void)whammyOn:(UIGestureRecognizer*)gesture
{
    [WhammyMidi whammyOn];
}

- (IBAction)back:(id)sender {
  [self.navigationController.sideMenu toggleRightSideMenu];
}

- (IBAction)quickModeBtnPressed:(id)sender {
  [self.navigationController.sideMenu toggleLeftSideMenu];
}

#pragma mark methods to overwrite
-(void)singleFingerTouch:(UITouch*)touch
{
  
}

-(void)singleFingerMoved:(UITouch*)touch
{
  
}

-(void)finishedHandleSingleTouch
{
  
}
@end
