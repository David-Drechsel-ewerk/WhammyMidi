//
//  SideMenuViewController.h
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"

@interface AppProgrammMenuViewController : UITableViewController<UISearchBarDelegate>

@property (nonatomic, assign) MFSideMenu *sideMenu;

@end