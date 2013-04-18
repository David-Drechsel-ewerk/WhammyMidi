//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "AppProgrammMenuViewController.h"
#import "MFSideMenu.h"
#import "AutoSnapViewController.h"
#import "ModeViewController.h"
#import "HoldPedalViewController.h"

@implementation AppProgrammMenuViewController

@synthesize sideMenu;

- (void) viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0];
  self.tableView.separatorColor = kBaseColor;
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
      cell.textLabel.textColor = kBaseColor;
      cell.selectionStyle = UITableViewCellSelectionStyleGray;
      
      UIView *backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
      backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
      cell.selectedBackgroundView = backgroundView;
    }
  
  NSString *cellTitle = @"";
  
  switch (indexPath.row)
  {
    case 0:
      cellTitle = @"Program";
      break;
    case 1:
      cellTitle = @"Autosnap";
      break;
    case 2:
      cellTitle = @"Hold";
      break;
    default:
      cellTitle = @"BUGS everywhere";
      break;
  }
  
  cell.textLabel.text = cellTitle;
  cell.textLabel.textAlignment = UITextAlignmentRight;
    
  return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIViewController *vc = nil;
  
  switch (indexPath.row)
  {
    case 0:
      vc = [[ModeViewController alloc] init];
      break;
    case 1:
      vc = [[AutoSnapViewController alloc] init];
      break;
    case 2:
      vc = [[HoldPedalViewController alloc] init];
      break;
    default:
      vc = [[ModeViewController alloc] init];
      break;
  }
  
    NSArray *controllers = [NSArray arrayWithObject:vc];
    self.sideMenu.navigationController.viewControllers = controllers;
    [self.sideMenu setMenuState:MFSideMenuStateClosed];
}

@end
