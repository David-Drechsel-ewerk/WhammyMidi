//
//  ModeViewController.m
//  MIDITest
//
//  Created by David Drechsel on 05.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "ModeViewController.h"
#import "WhammyMidi.h"

@interface ModeViewController ()

@end

@implementation ModeViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [WhammyMidi logAllInterfaces];
        [WhammyMidi program:WhammyProgramBypassedHarmonyOctDownOctUp];
    }
    return self;
}

#pragma mark actions

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [WhammyMidi logAllInterfaces];
}

#pragma mark Picker

- (IBAction)toggleWhammy:(UIButton*)sender
{
    if (sender.selected)
    {
        [WhammyMidi whammyOff];
    }
    else
    {
        [WhammyMidi whammyOn];
    }

    sender.selected = !sender.selected;
}

- (IBAction)harmonyUpDown:(UIButton*)sender {
    [WhammyMidi program:WhammyProgramBypassedHarmonyOctDownOctUp];
}

- (IBAction)octDown:(id)sender {
    [WhammyMidi program:WhammyProgramActiveOctDown];
}
- (IBAction)changedPedal:(UISlider*)sender {
    [WhammyMidi pedalPosition:sender.value];
    
}
- (IBAction)pedalTouchUp:(UISlider *)sender {
    [WhammyMidi pedalPosition:43];
    sender.value = 43;
}

- (void)viewDidUnload {
    [self setLabel:nil];
    [super viewDidUnload];
}
@end
