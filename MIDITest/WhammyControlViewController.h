//
//  WhammyControlViewController.h
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
#import <UIKit/UIKit.h>
#import "WhammyMidi.h"

#import <QuartzCore/QuartzCore.h>

#define kTouchTimerDelay 0.0f

@interface WhammyControlViewController : UIViewController <UIGestureRecognizerDelegate>
{
  NSTimeInterval touchTimerDelay;
  IBOutlet UIView *xyPad;
}

#pragma mark methods to overwrite
-(void)singleFingerTouch:(UITouch*)touch;
-(void)singleFingerMoved:(UITouch*)touch;
-(void)finishedHandleSingleTouch;

@end
