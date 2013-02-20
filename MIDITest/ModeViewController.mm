//
//  ModeViewController.m
//  MIDITest
//
//  Created by David Drechsel on 05.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "ModeViewController.h"
#import "WhammyMidi.h"
#import "ProgrammCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ModeViewController ()

@end

@implementation ModeViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [collectionView registerClass:[ProgrammCell class] forCellWithReuseIdentifier:@"Cell"];
    CALayer *onLayer = whammyOnBtn.layer;
    onLayer.borderColor = [UIColor redColor].CGColor;
    onLayer.borderWidth = 2;
    onLayer.cornerRadius = 45;
    CALayer *offLayer = whammyOffBtn.layer;
    offLayer.borderColor = [UIColor redColor].CGColor;
    offLayer.borderWidth = 2;
    offLayer.cornerRadius = 45;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 17;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProgrammCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.nameLbl.text = whammyProgramNames[17+indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)myCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [myCollectionView deselectItemAtIndexPath:indexPath animated:YES];
    [WhammyMidi program:WhammyProgramBypassedDetuneShallow+indexPath.row];
}

- (IBAction)pressedWhammyOn:(id)sender {
    [WhammyMidi whammyOn];
}

- (IBAction)pressedWhammyOff:(id)sender {
    [WhammyMidi whammyOff];
}
@end
