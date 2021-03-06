//
//  BRHomeViewController.h
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/8/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"

@interface BRHomeViewController : BRCoreViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *birthdays;

-(IBAction)unwindBackToHomeViewController:(UIStoryboardSegue *)segue;

@end
