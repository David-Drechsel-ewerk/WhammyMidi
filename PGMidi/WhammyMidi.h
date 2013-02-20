//
//  WhammyMidi.h
//  MIDITest
//
//  Created by David Drechsel on 05.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//
typedef enum {
  
  WhammyProgramActiveDetuneShallow = 0,
  WhammyProgramActiveDetuneDeep,
  WhammyProgramActive2OctUp,
  WhammyProgramActiveOctUp,
  WhammyProgramActiveOctDown,
  WhammyProgramActive2OctDown,
  WhammyProgramActiveDiveBomb,
  WhammyProgramActiveDroptune,
  WhammyProgramActiveHarmony2ndUp3rdUp,
  WhammyProgramActiveHarmony5thDown4rdDown,
  WhammyProgramActiveHarmony4thDown3rdDown,
  WhammyProgramActiveHarmony5thUp7thUp,
  WhammyProgramActiveHarmony5thUp6thUp,
  WhammyProgramActiveHarmony4thUp5thUp,
  WhammyProgramActiveHarmony3rdUp4thUp,
  WhammyProgramActiveHarmonyb3rdUp3rdUp,
  WhammyProgramActiveHarmonyOctDownOctUp,
  WhammyProgramBypassedDetuneShallow,
  WhammyProgramBypassedDetuneDeep,
  WhammyProgramBypassed2OctUp,
  WhammyProgramBypassedOctUp,
  WhammyProgramBypassedOctDown,
  WhammyProgramBypassed2OctDown,
  WhammyProgramBypassedDiveBomb,
  WhammyProgramBypassedDroptune,
  WhammyProgramBypassedHarmony2ndUp3rdUp,
  WhammyProgramBypassedHarmony5thDown4rdDown,
  WhammyProgramBypassedHarmony4thDown3rdDown,
  WhammyProgramBypassedHarmony5thUp7thUp,
  WhammyProgramBypassedHarmony5thUp6thUp,
  WhammyProgramBypassedHarmony4thUp5thUp,
  WhammyProgramBypassedHarmony3rdUp4thUp,
  WhammyProgramBypassedHarmonyb3rdUp3rdUp,
  WhammyProgramBypassedHarmonyOctDownOctUp,
  WhammyProgramCount
  
} WhammyProgram;

#define CountOfWhammyPrograms WhammyProgramCount

static NSArray *whammyProgramNames = @[//ActiveModes
                                       @"Detune Shallow",
                                       @"Detune Deep",
                                       @"2 Oct Up",
                                       @"Oct Up",
                                       @"Oct Down",
                                       @"2 Oct Down",
                                       @"Dive Bomb",
                                       @"Droptune",
                                       @"Harmony Oct Down Oct Up",
                                       @"Harmony 5th Down 4rd Down",
                                       @"Harmony 4th Down 3rd Down",
                                       @"Harmony 5th Up 7th Up",
                                       @"Harmony 5th Up 6th Up",
                                       @"Harmony 4th Up 5th Up",
                                       @"Harmony 3rd Up 4th Up",
                                       @"Harmony b3rd Up 3rd Up",
                                       @"Harmony 2nd Up 3rd Up",
                                       //BypassedModes
                                       @"Detune Shallow",
                                       @"Detune Deep",
                                       @"2 Oct Up",
                                       @"Oct Up",
                                       @"Oct Down",
                                       @"2 Oct Down",
                                       @"Dive Bomb",
                                       @"Droptune",
                                       @"Harmony Oct Down Oct Up",
                                       @"Harmony 5th Down 4rd Down",
                                       @"Harmony 4th Down 3rd Down",
                                       @"Harmony 5th Up 7th Up",
                                       @"Harmony 5th Up 6th Up",
                                       @"Harmony 4th Up 5th Up",
                                       @"Harmony 3rd Up 4th Up",
                                       @"Harmony b3rd Up 3rd Up",
                                       @"Harmony 2nd Up 3rd Up"];

@interface WhammyMidi : NSObject

+(void)logAllInterfaces;

+(void)whammyOn;
+(void)whammyOff;
+(void)program:(int)program;
+(void)pedalPosition:(int)position;

//+(void)sendCommand:(const UInt8*)command;
//+(void)sendCommand:(const UInt8*)command withAfterDelay:(float)holdTime;

@end

