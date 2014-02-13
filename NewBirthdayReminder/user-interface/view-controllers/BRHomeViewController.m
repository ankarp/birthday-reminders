//
//  BRHomeViewController.m
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/8/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import "BRHomeViewController.h"
#import "BRBirthdayDetailViewController.h"
#import "BRBirthdayEditViewController.h"
#import "BRDBirthday.h"
#import "BRDModel.h"

@interface BRHomeViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController; // should this go to the header??

@end

@implementation BRHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"birthdays" ofType:@"plist"];
        NSArray *nonMutableBirthdays = [NSArray arrayWithContentsOfFile:plistPath];

        BRDBirthday *birthday;
        NSDictionary *dictionary;
        NSString *name;
        NSString *pic;
        NSString *pathForPic;
        NSData *imageData;
        NSDate *birthdate;
        NSCalendar *calendar = [NSCalendar currentCalendar];

        NSString *uid;
        NSMutableArray *uids = [NSMutableArray array];
        for (int i = 0; i < [nonMutableBirthdays count]; i++) {
            dictionary = [nonMutableBirthdays objectAtIndex:i];
            uid = dictionary[@"name"];
            [uids addObject:uid];
        }
        NSMutableDictionary *existingEntities = [[BRDModel sharedInstance] getExistingBirthdatsWithUIDs:uids];

        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;

        for (int i = 0; i < [nonMutableBirthdays count]; i++) {
            dictionary = nonMutableBirthdays[i];
            uid = dictionary[@"name"];
            birthday = existingEntities[uid];
            if (! birthday) {
                birthday = [NSEntityDescription insertNewObjectForEntityForName:@"BRDBirthday" inManagedObjectContext:context];
                existingEntities[uid] = birthday;
                birthday.uid = uid;
            }

            name = dictionary[@"name"];
            pic = dictionary[@"pic"];
            birthdate = dictionary[@"birthdate"];
            pathForPic = [[NSBundle mainBundle] pathForResource:pic ofType:nil];
            imageData = [NSData dataWithContentsOfFile:pathForPic];
            birthday.name = name;
            birthday.imageData = imageData;
            NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:birthdate];
            birthday.birthDay = @(components.day);
            birthday.birthMonth = @(components.month);
            birthday.birthYear = @(components.year);
            [birthday updateNextBirthdayAndAge];
        }
        [[BRDModel sharedInstance] saveChanges];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(IBAction)unwindBackToHomeViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"unwindBackToHomeViewController");
}

#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];

    BRDBirthday *birthday = [self.fetchedResultsController objectAtIndexPath:indexPath];

    cell.textLabel.text = birthday.name;
    cell.detailTextLabel.text = birthday.birthdayTextToDisplay;
    cell.imageView.image = [UIImage imageWithData:birthday.imageData];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

#pragma mar UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Segues

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;

    if ([identifier isEqualToString:@"BirthdayDetail"]) {
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        NSMutableDictionary *birthday = self.birthdays[selectedIndexPath.row];

        BRBirthdayDetailViewController *birthdayDetailViewController = segue.destinationViewController;
        birthdayDetailViewController.birthday = birthday;
    }
    else if ([identifier isEqualToString:@"AddBirthday"]) {
        NSMutableDictionary *birthday = [NSMutableDictionary dictionary];
        birthday[@"name"] = @"My Friend";
        birthday[@"birthdate"] = [NSDate date];
        UINavigationController *navigationController = segue.destinationViewController;
        BRBirthdayEditViewController *birthdayEditViewController = (BRBirthdayEditViewController *) navigationController.topViewController;
        birthdayEditViewController.birthday = birthday;
    }
}

#pragma mark Fetched Results Controller to keep track of the Core Data BRDBirthday managed objects

-(NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

        // access the single managed object context through model singleton
        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;

        //fetch request requires an entity description - we're only interested in BRDBirthday managed objects
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"BRDBirthday" inManagedObjectContext:context];
        fetchRequest.entity = entity;

        // we'll order the BRDBirthday objects in name sort order for now
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nextBirthday" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        fetchRequest.sortDescriptors = sortDescriptors;

        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        self.fetchedResultsController.delegate = self;
        NSError *error = nil;
        if (![self.fetchedResultsController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }

    return _fetchedResultsController;
}

#pragma mark NSFetchedResultsControllerDelegate

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // the fetched results changed.
}
@end
