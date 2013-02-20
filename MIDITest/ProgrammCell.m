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



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProgrammCell" owner:self options:nil];
    
        if ([arrayOfViews count] < 1) { return nil; }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) { return nil; }
        
        self = [arrayOfViews objectAtIndex:0];

        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView = selectedBackgroundView;
        
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.351 green:0 blue:0.010 alpha:1];
        CALayer *contentLayer = self.layer;
        contentLayer.borderColor = [UIColor redColor].CGColor;
        contentLayer.borderWidth = 2;
        contentLayer.cornerRadius = 16;
    }
    
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
