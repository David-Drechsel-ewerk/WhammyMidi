//
//  HoldPedalViewController.m
//  MIDITest
//
//  Created by David Drechsel on 21.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "HoldPedalViewController.h"
#import "MenuViewController.h"

#define kTouchTimerDelay 0.12f

@interface HoldPedalViewController ()
{
  IBOutlet UIView *snapper;
  IBOutlet UIView *leftView;
  IBOutlet UIView *rightView;
    
  NSMutableArray *touchesInView;
  NSTimer *delayTimer;
  NSTimer *pedalTimer;
  
  NSTimeInterval portamentoTime;
  
  BOOL pedalDown;
  BOOL handlesTouch;
  
  int portamentoPedalPosition;
}

@end

@implementation HoldPedalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      portamentoTime = 1.0f;
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
    [pedalTimer invalidate];
    [WhammyMidi pedalPosition:pedalDown ? WhammyPedalPositionMin : WhammyPedalPositionMax];
    //[self updateUIForPedalPosition:pedalDown ? WhammyPedalPositionMin : WhammyPedalPositionMax];

    [UIView animateWithDuration:0.3
                     animations:^{
                       [self updateUIForPedalPosition:pedalDown ? WhammyPedalPositionMax : WhammyPedalPositionMin];
                       leftView.hidden = !pedalDown;
                       rightView.hidden = !leftView.hidden;
                     }];
    
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
  float pedalPositionConvertedToView = self.view.bounds.size.width/2/WhammyPedalPositionMax*position;
  if (!pedalDown)
  {
    pedalPositionConvertedToView += self.view.bounds.size.width/2;
  }
  float snapPosition = self.view.bounds.size.width/2;
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
- (IBAction)back:(id)sender {
  MenuViewController *mVC = [[MenuViewController alloc] init];
  self.view.window.rootViewController = mVC;
}

@end
