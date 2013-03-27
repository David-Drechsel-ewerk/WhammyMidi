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
#import "DelayedButtonViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MTInfoPanel.h"

#import "MenuViewController.h"

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
  
  //add Back Button
  DelayedButtonViewController *backBtn = [[DelayedButtonViewController alloc] initWithNibName:@"DelayedButtonViewController" bundle:nil];
  [self addChildViewController:backBtn];
  backBtn.delay = 0.3f;
  backBtn.image = [UIImage imageNamed:@"back"];
  backBtn.delegate = self;
  backBtn.btnFiredSelector = @selector(back:);
  [self.view addSubview:backBtn.view];
  backBtn.view.frame = CGRectMake(415, 0, 44, 44);
  
    CALayer *onLayer = whammyOnBtn.layer;
    onLayer.borderColor = [UIColor redColor].CGColor;
    onLayer.borderWidth = 2;
    onLayer.cornerRadius = 8;
    CALayer *offLayer = whammyOffBtn.layer;
    offLayer.borderColor = [UIColor redColor].CGColor;
    offLayer.borderWidth = 2;
    offLayer.cornerRadius = 8;
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
    [MTInfoPanel showPanelInView:self.view type:MTInfoPanelTypeWarning title:@"Whammy On" subtitle:nil hideAfter:0.6f];
}

- (IBAction)pressedWhammyOff:(id)sender {
    [WhammyMidi whammyOff];
    [MTInfoPanel showPanelInView:self.view type:MTInfoPanelTypeWarning title:@"Whammy Off" subtitle:nil hideAfter:0.6f];
}

- (IBAction)back:(id)sender {        
  MenuViewController *mVC = [[MenuViewController alloc] init];
  self.view.window.rootViewController = mVC;

}
@end
