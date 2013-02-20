#import "PGMidi.h"
#import "iOSVersionDetection.h"
#import <CoreMIDI/CoreMIDI.h>
#import "WhammyMidi.h"

@implementation WhammyMidi : NSObject 

const char *ToString(BOOL b) { return b ? "yes":"no"; }

NSString *ToString(PGMidiConnection *connection)
{
    return [NSString stringWithFormat:@"< PGMidiConnection: name=%@ isNetwork=%s >",
            connection.name, ToString(connection.isNetworkSession)];
}

+(void)logAllInterfaces
{
    PGMidi *midi = [PGMidi sharedPGMidi];
    midi.networkEnabled = YES;
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


#pragma mark control
+(void)whammyOn
{
    const UInt8 command[] = {0xB0, 0, 127};
    [self sendCommand:command size:sizeof(command)];
}

+(void)whammyOff
{
    const UInt8 command[] = {0xB0, 0, 0};
    [self sendCommand:command size:sizeof(command)];
}

+(void)program:(int)program
{
    const UInt8 command[] = {0xC0, program};
    [self sendCommand:command size:sizeof(command)];
}

+(void)pedalPosition:(int)position
{
    const UInt8 command[] = {0xB0, 11, position};
    [self sendCommand:command size:sizeof(command)];
}

+(void)sendCommand:(const UInt8*)command size:(int)size
{
    [self sendCommand:command withAfterDelay:0.1 size:size];
}

+(void)sendCommand:(const UInt8*)command withAfterDelay:(float)holdTime size:(int)size
{
    PGMidi *midi = [PGMidi sharedPGMidi];
    [midi sendBytes:command size:size];
}



@end