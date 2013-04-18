//
//  AppDelegate.m
//  MIDITest
//
//  Created by David Drechsel on 05.02.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "AppDelegate.h"
#import "WhammyMidi.h"
#import "AppProgrammMenuViewController.h"
#import "ModeViewController.h"
#import "FavModeCollectionViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [UIApplication sharedApplication].idleTimerDisabled = YES;
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  [WhammyMidi logAllInterfaces];
  
  ModeViewController *modeVC = [[ModeViewController alloc] initWithNibName:@"ModeViewController" bundle:nil];

  UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:modeVC];
  navCon.navigationBarHidden = YES;
  
  AppProgrammMenuViewController *rightSideMenuController = [[AppProgrammMenuViewController alloc] init];
  
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
  [flowLayout setItemSize:CGSizeMake(100, 100)];
  [flowLayout setMinimumInteritemSpacing:0.0f];
  [flowLayout setMinimumLineSpacing:10.0f];
  
  FavModeCollectionViewController *leftSideMenuController = [[FavModeCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
  
  MFSideMenu *sideMenu = [MFSideMenu menuWithNavigationController:navCon
                                           leftSideMenuController:leftSideMenuController
                                          rightSideMenuController:rightSideMenuController
                                                          panMode:MFSideMenuPanModeSideMenu];
  sideMenu.menuWidth = 120;
  rightSideMenuController.sideMenu = sideMenu;
  
  self.window.rootViewController = sideMenu.navigationController;
  
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
