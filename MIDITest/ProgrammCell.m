//
//  ProgrammCell.m
//  MIDITest
//
//  Created by David Drechsel on 20.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "ProgrammCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ProgrammCell
@synthesize nameLbl;



- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
    // Initialization code
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProgrammCell" owner:self options:nil];

    if ([arrayOfViews count] < 1) { return nil; }
    
    if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) { return nil; }
    self = [arrayOfViews objectAtIndex:0];
  
  
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    selectedBackgroundView.layer.cornerRadius = 8;
    selectedBackgroundView.layer.masksToBounds = YES;
    self.selectedBackgroundView = selectedBackgroundView;
    self.selectedBackgroundView.backgroundColor = kHighlightColor;
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
  
    CALayer *contentLayer = self.layer;
    contentLayer.borderColor = kBaseColor.CGColor;
    contentLayer.borderWidth = 2;
    contentLayer.masksToBounds = NO;
    contentLayer.cornerRadius = 8;
//    contentLayer.shadowColor = [UIColor blackColor].CGColor;
//    contentLayer.shadowOffset = CGSizeZero;
//    contentLayer.shadowRadius = 3.0f;
//    contentLayer.shadowOpacity = 0.8f;
    

  }
  return self;
}

@end
