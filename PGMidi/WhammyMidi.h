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

static NSArray *whammyProgramNames = @[@"ActiveDetuneShallow",
                                       @"ActiveDetuneDeep",
                                       @"Active2OctUp",
                                       @"ActiveOctUp",
                                       @"ActiveOctDown",
                                       @"Active2OctDown",
                                       @"ActiveDiveBomb",
                                       @"ActiveDroptune",
                                       @"ActiveHarmonyOctDownOctUp",
                                       @"ActiveHarmony5thDown4rdDown",
                                       @"ActiveHarmony4thDown3rdDown",
                                       @"ActiveHarmony5thUp7thUp",
                                       @"ActiveHarmony5thUp6thUp",
                                       @"ActiveHarmony4thUp5thUp",
                                       @"ActiveHarmony3rdUp4thUp",
                                       @"ActiveHarmonyb3rdUp3rdUp",
                                       @"ActiveHarmony2ndUp3rdUp",
                                       @"BypassedDetuneShallow",
                                       @"BypassedDetuneDeep",
                                       @"Bypassed2OctUp",
                                       @"BypassedOctUp",
                                       @"BypassedOctDown",
                                       @"Bypassed2OctDown",
                                       @"BypassedDiveBomb",
                                       @"BypassedDroptune",
                                       @"BypassedHarmonyOctDownOctUp",
                                       @"BypassedHarmony5thDown4rdDown",
                                       @"BypassedHarmony4thDown3rdDown",
                                       @"BypassedHarmony5thUp7thUp",
                                       @"BypassedHarmony5thUp6thUp",
                                       @"BypassedHarmony4thUp5thUp",
                                       @"BypassedHarmony3rdUp4thUp",
                                       @"BypassedHarmonyb3rdUp3rdUp",
                                       @"BypassedHarmony2ndUp3rdUp"];

@interface WhammyMidi : NSObject

+(void)logAllInterfaces;

+(void)whammyOn;
+(void)whammyOff;
+(void)program:(int)program;
+(void)pedalPosition:(int)position;

+(void)sendCommand:(const UInt8*)command;
+(void)sendCommand:(const UInt8*)command withAfterDelay:(float)holdTime;

@end

