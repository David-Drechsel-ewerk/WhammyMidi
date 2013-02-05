//
//  WhammyMidi.h
//  MIDITest
//
//  Created by David Drechsel on 05.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#define NoteOn(note, velocity) {0x80, (note), (velocity)}
#define NoteOff(note) {0x80, (note), 0}

#define WhammyProgram(program) {0xC0, (program), 0} //different programcodes for active or bypassed

#define WhammyOn {0xB0, 0, 0}
#define WhammyOff {0xB0, 0 127}

#define PedalPosition(position) {0xB0, 2, (position)}

typedef enum {
  
  WhammyProgramInvalid = 0,
  WhammyProgramActiveDetuneShallow,
  WhammyProgramActiveDetuneDeep,
  WhammyProgramActive2OctUp,
  WhammyProgramActiveOctUp,
  WhammyProgramActiveOctDown,
  WhammyProgramActive2OctDown,
  WhammyProgramActiveDiveBomb,
  WhammyProgramActiveDroptune,
  WhammyProgramActiveHarmonyOctDownOctUp,
  WhammyProgramActiveHarmony5thDown4rdDown,
  WhammyProgramActiveHarmony4thDown3rdDown,
  WhammyProgramActiveHarmony5thUp7thUp,
  WhammyProgramActiveHarmony5thUp6thUp,
  WhammyProgramActiveHarmony4thUp5thUp,
  WhammyProgramActiveHarmony3rdUp4thUp,
  WhammyProgramActiveHarmonyb3rdUp3rdUp,
  WhammyProgramActiveHarmony2ndUp3rdUp,
  
  WhammyProgramBypassedDetuneShallow,
  WhammyProgramBypassedDetuneDeep,
  WhammyProgramBypassed2OctUp,
  WhammyProgramBypassedOctUp,
  WhammyProgramBypassedOctDown,
  WhammyProgramBypassed2OctDown,
  WhammyProgramBypassedDiveBomb,
  WhammyProgramBypassedDroptune,
  WhammyProgramBypassedHarmonyOctDownOctUp,
  WhammyProgramBypassedHarmony5thDown4rdDown,
  WhammyProgramBypassedHarmony4thDown3rdDown,
  WhammyProgramBypassedHarmony5thUp7thUp,
  WhammyProgramBypassedHarmony5thUp6thUp,
  WhammyProgramBypassedHarmony4thUp5thUp,
  WhammyProgramBypassedHarmony3rdUp4thUp,
  WhammyProgramBypassedHarmonyb3rdUp3rdUp,
  WhammyProgramBypassedHarmony2ndUp3rdUp,
  WhammyProgramCount
  
} WhammyProgram;

#define CountOfWhammyPrograms WhammyProgramCount-2

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

