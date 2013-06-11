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

typedef enum  {
  TouchUpModeOff,
  TouchUpModeMin,
  TouchUpModeMiddle,
  TouchUpModeMax
} TouchUpMode;

@interface AutoSnapViewController ()
{
  IBOutlet UISegmentedControl *touchUpModeControl;
  IBOutlet UIView *snapper;
  IBOutlet UIView *settingsView;
  IBOutlet UILabel *touchModeLbl;
    
  float autoSnapPoint;
  BOOL whammyOffOnTouchUp;
}

-(IBAction)touchOffModeChanged:(id)sender;

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
  
  DelayedButtonViewController *settingsBtn = [[DelayedButtonViewController alloc] initWithNibName:@"DelayedButtonViewController" bundle:nil];
  [self addChildViewController:settingsBtn];
  settingsBtn.delay = 0.5;
  settingsBtn.image = [UIImage imageNamed:@"settings"];
  settingsBtn.text = nil;
  settingsBtn.delegate = self;
  settingsBtn.btnFiredSelector = @selector(showSettings);
  [self.view addSubview:settingsBtn.view];
  settingsBtn.view.frame = CGRectMake(self.view.frame.size.width-47, 80, 44, 44);

  settingsView.layer.borderColor = kBaseColor.CGColor;
  settingsView.layer.borderWidth = 1;
  settingsView.layer.cornerRadius = 8;
  settingsView.layer.masksToBounds = YES;
  
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [touchUpModeControl setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults] integerForKey:@"TouchUpMode"]];
  
  [self touchOffModeChanged:touchUpModeControl];
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
    [UIView animateWithDuration:0.1f animations:^{
          snapper.frame = snapperFrame;
    }];
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

-(void)showSettings
{
  if (!([settingsView isDescendantOfView:self.view]))
  {
    settingsView.center = xyPad.superview.center;
    settingsView.frame = CGRectOffset(settingsView.frame, 0, -settingsView.frame.origin.y-settingsView.frame.size.height);
    [self.view addSubview:settingsView];
    [UIView animateWithDuration:0.3f animations:^{
      settingsView.center = xyPad.superview.center;
    }];
  }
  else
  {
    [UIView animateWithDuration:0.3f
                     animations:^{
                       settingsView.frame = CGRectOffset(settingsView.frame, 0, -settingsView.frame.origin.y-settingsView.frame.size.height);
                     } completion:^(BOOL finished) {
                           [settingsView removeFromSuperview];
                     }];
  }
}

-(void)touchOffModeChanged:(UISegmentedControl*)sender
{
  switch (sender.selectedSegmentIndex)
  {
    case TouchUpModeOff: {
      [self setWhammyOffOnTouchUp:YES];
      touchModeLbl.text = @"Mode: Off";
      break;
    }
    case TouchUpModeMin: {
      autoSnapPoint = 0.0;
      [self setWhammyOffOnTouchUp:NO];
      touchModeLbl.text = @"Mode: Min";
      break;
    }
    case TouchUpModeMiddle: {
      autoSnapPoint = 0.5;
      [self setWhammyOffOnTouchUp:NO];
      touchModeLbl.text = @"Mode: Half";
      break;
    }
    case TouchUpModeMax: {
      autoSnapPoint = 1.0;
      [self setWhammyOffOnTouchUp:NO];
      touchModeLbl.text = @"Mode: Max";
      break;
    }
    default:
      [self setWhammyOffOnTouchUp:YES];
      break;
  }
  [[NSUserDefaults standardUserDefaults] setInteger:sender.selectedSegmentIndex forKey:@"TouchUpMode"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma singleTouch
-(void)singleFingerTouch:(UITouch*)touch
{
  if ([settingsView isDescendantOfView:self.view])
  {
    [self showSettings];
    return;
  }
  
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
