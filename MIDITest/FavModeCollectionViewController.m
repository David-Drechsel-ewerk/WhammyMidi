//
//  FavModeCollectionViewController.m
//  MIDITest
//
//  Created by David Drechsel on 18.04.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "FavModeCollectionViewController.h"
#import "ProgrammCell.h"
#import "WhammyMidi.h"

@implementation FavModeCollectionViewController
{
  NSArray *favs;
}

+(UICollectionViewLayout*)predefinedLayout
{
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
  [flowLayout setItemSize:CGSizeMake(100, 90)];
  [flowLayout setMinimumInteritemSpacing:0.0f];
  [flowLayout setMinimumLineSpacing:10.0f];
  [flowLayout setSectionInset:UIEdgeInsetsMake(5, 10, 0, 10)];
  return flowLayout;
}

-(void)viewDidLoad
{
  [super viewDidLoad];
  self.collectionView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0];
  
  favs = [NSArray arrayWithObjects:[NSNumber numberWithInt:WhammyProgramBypassedHarmonyOctDownOctUp],
                                   [NSNumber numberWithInt:WhammyProgramBypassedOctUp],
                                   [NSNumber numberWithInt:WhammyProgramBypassedDiveBomb],
          nil];
  
  [self.collectionView registerClass:[ProgrammCell class] forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
  return [favs count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  ProgrammCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.nameLbl.text = whammyProgramNames[[[favs objectAtIndex:indexPath.row] intValue]];
  return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)myCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  [myCollectionView deselectItemAtIndexPath:indexPath animated:YES];
  [WhammyMidi program:[[favs objectAtIndex:indexPath.row] intValue]];
}


@end
