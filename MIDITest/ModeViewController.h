//
//  ModeViewController.h
//  MIDITest
//
//  Created by David Drechsel on 05.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView *collectionView;
    IBOutlet UIButton *whammyOnBtn;
    IBOutlet UIButton *whammyOffBtn;
}

- (IBAction)pressedWhammyOn:(id)sender;
- (IBAction)pressedWhammyOff:(id)sender;


@end
