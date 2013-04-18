//
//  MenuViewController.m
//  MIDITest
//
//  Created by David Drechsel on 21.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "MenuViewController.h"
#import "AutoSnapViewController.h"
#import "ModeViewController.h"
#import "HoldPedalViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (IBAction)showProgramMode:(id)sender
{
  ModeViewController *mVC = [[ModeViewController alloc] init];
  self.view.window.rootViewController = mVC;  
}

- (IBAction)showAutoSnapMode:(id)sender
{
  AutoSnapViewController *mVC = [[AutoSnapViewController alloc] init];
  self.view.window.rootViewController = mVC;  
}

- (IBAction)showHoldToggleMode:(id)sender
{
  HoldPedalViewController *mVC = [[HoldPedalViewController alloc] init];
  self.view.window.rootViewController = mVC;
}

@end
