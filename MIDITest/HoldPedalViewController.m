//
//  HoldPedalViewController.m
//  MIDITest
//
//  Created by David Drechsel on 21.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "HoldPedalViewController.h"
#import "MenuViewController.h"

@interface HoldPedalViewController ()
{
  IBOutlet UIView *snapper;
  IBOutlet UIView *leftView;
  IBOutlet UIView *rightView;
  
  NSTimer *pedalTimer;
  NSTimeInterval portamentoTime;
  BOOL pedalDown;
  int portamentoPedalPosition;
}

@end

@implementation HoldPedalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      portamentoTime = 0.7f;
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

-(void)finishedHandleSingleTouch
{
  [pedalTimer invalidate];
  [WhammyMidi pedalPosition:pedalDown ? WhammyPedalPositionMin : WhammyPedalPositionMax];
  //[self updateUIForPedalPosition:pedalDown ? WhammyPedalPositionMin : WhammyPedalPositionMax];
  
  [UIView animateWithDuration:0.3
                   animations:^{
                     [self updateUIForPedalPosition:pedalDown ? WhammyPedalPositionMax : WhammyPedalPositionMin];
                     leftView.hidden = !pedalDown;
                     rightView.hidden = !leftView.hidden;
                   }];
}

-(void)singleFingerTouch:(UITouch*)touch
{
  pedalDown = [touch locationInView:self.view].x < self.view.bounds.size.width/2;
  
  [WhammyMidi whammyOn];
  portamentoPedalPosition = pedalDown ? WhammyPedalPositionMax : WhammyPedalPositionMin;
  pedalTimer = [NSTimer scheduledTimerWithTimeInterval:portamentoTime/WhammyPedalPositionMax
                                                target:self selector:@selector(portamentoStep)
                                              userInfo:nil
                                               repeats:YES];
}

-(void)portamentoStep
{
  portamentoPedalPosition = pedalDown ? portamentoPedalPosition-1 : portamentoPedalPosition+1;
  if (portamentoPedalPosition < WhammyPedalPositionMin || portamentoPedalPosition > WhammyPedalPositionMax)
  {
    [pedalTimer invalidate];
    return;
  }
  [WhammyMidi pedalPosition:portamentoPedalPosition];
  [self updateUIForPedalPosition:portamentoPedalPosition];
}

-(void)updateUIForPedalPosition:(float)position
{
  float pedalPositionConvertedToView = xyPad.bounds.size.width/2/WhammyPedalPositionMax*position;
  if (!pedalDown)
  {
    pedalPositionConvertedToView += xyPad.bounds.size.width/2;
  }
  float snapPosition = xyPad.bounds.size.width/2;
  float newXyPadWidth = pedalPositionConvertedToView - snapPosition;
  CGRect snapperFrame = snapper.frame;
  snapperFrame.origin.x = newXyPadWidth < 0 ? pedalPositionConvertedToView : snapPosition;
  snapperFrame.size.width = fabs(newXyPadWidth);
  if (snapperFrame.size.width < 1.0f)
  {
    snapperFrame.size.width = 1.0f;
  }
  snapper.frame = snapperFrame;
}

@end
