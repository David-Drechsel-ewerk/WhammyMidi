//
//  ModeViewController.m
//  MIDITest
//
//  Created by David Drechsel on 05.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "ModeViewController.h"
#import "PGMidi.h"
#import "iOSVersionDetection.h"
#import <CoreMIDI/CoreMIDI.h>
#import "WhammyMidi.h"

UInt8 RandomNoteNumber() { return UInt8(rand() / (RAND_MAX / 127)); }

const char *ToString(BOOL b) { return b ? "yes":"no"; }

NSString *ToString(PGMidiConnection *connection)
{
  return [NSString stringWithFormat:@"< PGMidiConnection: name=%@ isNetwork=%s >",
          connection.name, ToString(connection.isNetworkSession)];
}

@interface ModeViewController () <PGMidiDelegate, PGMidiSourceDelegate>

@end

@implementation ModeViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark mididelegate

-(void)midi:(PGMidi*)midi sourceAdded:(PGMidiSource *)source
{
  
}

-(void)midi:(PGMidi*)midi sourceRemoved:(PGMidiSource *)source
{

}

-(void)midi:(PGMidi*)midi destinationAdded:(PGMidiDestination *)destination
{

}

-(void)midi:(PGMidi*)midi destinationRemoved:(PGMidiDestination *)destination
{

}

-(void)midiSource:(PGMidiSource*)midi midiReceived:(const MIDIPacketList *)packetList
{
  
}

#pragma mark actions

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self listAllInterfaces];
}

-(IBAction)listAllInterfaces
{
  PGMidi *midi = [PGMidi sharedPGMidi];
  NSLog(@"%@", midi);
  NSLog(@"sources:");
  for (PGMidiSource *source in midi.sources)
  {
    NSLog(@"%@", ToString(source));
    
  }
  NSLog(@"destinations");
  for (PGMidiDestination *destination in midi.destinations)
  {
    NSLog(@"%@", ToString(destination));
  }
  NSLog(@"end list");
}

#pragma mark Picker

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  return CountOfWhammyPrograms;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  return whammyProgramNames[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  NSLog(@"selectedProgram: %@", whammyProgramNames[row]);
  PGMidi *midi = [PGMidi sharedPGMidi];
  
  const UInt8 programChange[]  = WhammyProgram(row+1);
  [midi sendBytes:programChange size:sizeof(programChange)];
}

@end
