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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
