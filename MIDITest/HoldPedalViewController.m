//
//  HoldPedalViewController.m
//  MIDITest
//
//  Created by David Drechsel on 21.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "HoldPedalViewController.h"

#define kTouchTimerDelay 0.12f

@interface HoldPedalViewController ()
{
  NSMutableArray *touchesInView;
  NSTimer *delayTimer;
  NSTimer *pedalTimer;
  
  BOOL pedalDown;
  BOOL handlesTouch;
}

@end

@implementation HoldPedalViewController

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
  // Do any additional setup after loading the view from its nib.
  touchesInView = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark gestureDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  return !handlesTouch;
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
    delayTimer = [NSTimer scheduledTimerWithTimeInterval:kTouchTimerDelay
                                                  target:self
                                                selector:@selector(handleButtonTouch)
                                                userInfo:nil
                                                 repeats:NO];
  }
  [touchesInView addObjectsFromArray:[touches allObjects]];
  [self checkTouches];
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
  [touchesInView removeObjectsInArray:[touches allObjects]];
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
    [WhammyMidi pedalPosition:pedalDown ? WhammyPedalPositionMin : WhammyPedalPositionMax];
    handlesTouch = NO;
  }
}

-(void)handleButtonTouch
{
  //this method should only trigger if exactly one touch is recognized.
  NSAssert([touchesInView count] == 1, @"handleButtonTouch with != one recognized touch");
  UITouch *touch = [touchesInView objectAtIndex:0];
  handlesTouch = YES;
  pedalDown = [touch locationInView:self.view].x < self.view.bounds.size.width/2;
}

@end
