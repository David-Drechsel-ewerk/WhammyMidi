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
#import "MFSideMenu.h"

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

-(void)viewDidLoad
{
  [super viewDidLoad];
  [collectionView registerClass:[ProgrammCell class] forCellWithReuseIdentifier:@"Cell"];

  //add Back Button
  DelayedButtonViewController *backBtn = [[DelayedButtonViewController alloc] initWithNibName:@"DelayedButtonViewController" bundle:nil];
  [self addChildViewController:backBtn];
  backBtn.delay = 0.3f;
  backBtn.image = [UIImage imageNamed:@"menu-icon"];
  backBtn.delegate = self;
  backBtn.btnFiredSelector = @selector(back:);
  [self.view addSubview:backBtn.view];
  backBtn.view.frame = CGRectMake(self.view.frame.size.width-67, 30, 44, 44);
  
//  CALayer *collLayer = collectionView.layer;
//  collLayer.shadowColor = [UIColor blackColor].CGColor;
//  collLayer.shadowOffset = CGSizeZero;
//  collLayer.shadowRadius = 3.0f;
//  collLayer.shadowOpacity = 0.8f;
  
  whammyOnBtn.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
  whammyOffBtn.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
  
  CALayer *onLayer = whammyOnBtn.layer;
  onLayer.borderColor = kBaseColor.CGColor;
  onLayer.borderWidth = 2;
  onLayer.masksToBounds = NO;
  onLayer.cornerRadius = 8;
  onLayer.shadowColor = [UIColor blackColor].CGColor;
  onLayer.shadowOffset = CGSizeZero;
  onLayer.shadowRadius = 3.0f;
  onLayer.shadowOpacity = 0.8f;
  CALayer *offLayer = whammyOffBtn.layer;
  offLayer.borderColor = kBaseColor.CGColor;
  offLayer.borderWidth = 2;
  offLayer.masksToBounds = NO;
  offLayer.cornerRadius = 8;
  offLayer.shadowColor = [UIColor blackColor].CGColor;
  offLayer.shadowOffset = CGSizeZero;
  offLayer.shadowRadius = 3.0f;
  offLayer.shadowOpacity = 0.8f;  
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void) dealloc {
  self.navigationController.sideMenu.menuStateEventBlock = nil;
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
  switch (section)
  {
    case 0:
      return 8;
      break;
    case 1:
      return 9;
      break;
    default:
      return 0;
      break;
  }
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  ProgrammCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  int offset = (indexPath.section == 0) ? 0 : 8;
  cell.nameLbl.text = whammyProgramNames[17+offset+indexPath.row];
  return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)myCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [myCollectionView deselectItemAtIndexPath:indexPath animated:YES];
    int offset = (indexPath.section == 0) ? 0 : 8;
    [WhammyMidi program:WhammyProgramBypassedDetuneShallow+offset+indexPath.row];
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
  [self.navigationController.sideMenu toggleRightSideMenu];
}
@end
