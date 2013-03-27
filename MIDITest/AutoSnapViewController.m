//
//  AutoSnapViewController.m
//  MIDITest
//
//  Created by David Drechsel on 20.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "AutoSnapViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "MenuViewController.h"

@interface AutoSnapViewController ()
{
    IBOutlet UIView *snapper;
    
    float autoSnapPoint;
    BOOL whammyOffOnTouchUp;
}

@end

@implementation AutoSnapViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    autoSnapPoint = 0.5;
    [self setWhammyOffOnTouchUp:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateUIForTouchPosition:(float)position
{
    float snapPosition = whammyOffOnTouchUp ? 0 : xyPad.frame.size.width*autoSnapPoint;
    
    float newXyPadWidth = position - snapPosition;

    CGRect snapperFrame = snapper.frame;
    snapperFrame.origin.x = newXyPadWidth < 0 ? position : snapPosition;
    snapperFrame.size.width = fabs(newXyPadWidth);
    if (snapperFrame.size.width < 1.0f)
    {
        snapperFrame.size.width = 1.0f;
    }
    snapper.frame = snapperFrame;
}

-(void)snapperUIForWhammyOffMode
{
    CGRect snapperFrame = snapper.frame;
    snapperFrame.origin.x = -10.0f;
    snapperFrame.size.width = 1.0f;
    snapper.frame = snapperFrame;
}

#pragma settings
-(void)setWhammyOffOnTouchUp:(BOOL)off
{
  whammyOffOnTouchUp = off;
  //hide the snapperView, because its not needed if whammy turns off
  if (whammyOffOnTouchUp)
  {
    [self snapperUIForWhammyOffMode];
  }
  else
  {
    touchTimerDelay = kTouchTimerDelay;
  }
}

#pragma singleTouch
-(void)singleFingerTouch:(UITouch*)touch
{
  [super singleFingerTouch:touch];
  [WhammyMidi whammyOn];
  [self touchPositionToPedal:touch];
}

-(void)singleFingerMoved:(UITouch*)touch
{
  [super singleFingerMoved:touch];
  [self touchPositionToPedal:touch];
}

-(void)touchPositionToPedal:(UITouch*)touch
{
  CGPoint location = [touch locationInView:xyPad];
  //normalize to xyPad
  if (location.x < 0)
  {
    location.x = 0.0;
  }
  else if (location.x > xyPad.frame.size.width)
  {
    location.x = xyPad.frame.size.width;
  }
  //normalize to MIDI (0 - 127)
  float locationToPedal = location.x/xyPad.frame.size.width*127;
  
  [WhammyMidi pedalPosition:locationToPedal];
  [self updateUIForTouchPosition:location.x];
}

-(void)finishedHandleSingleTouch
{
  [super finishedHandleSingleTouch];
  if (whammyOffOnTouchUp)
  {
    [WhammyMidi whammyOff];
    [self snapperUIForWhammyOffMode];
  }
  else
  {
    [WhammyMidi pedalPosition:127.0f*autoSnapPoint];
    [self updateUIForTouchPosition:xyPad.frame.size.width*autoSnapPoint];
  }
}
@end
