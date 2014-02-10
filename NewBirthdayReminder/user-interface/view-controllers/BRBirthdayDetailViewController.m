//
//  BRBirthdayDetailViewController.m
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/8/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import "BRBirthdayDetailViewController.h"
#import "BRBirthdayEditViewController.h"

@interface BRBirthdayDetailViewController ()

@end

@implementation BRBirthdayDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    NSString *name = self.birthday[@"name"];
    self.title = name;
    UIImage *image = self.birthday[@"image"];
    if (image == nil) {
        self.photoView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
    } else {
        self.photoView.image = image;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"EditBirthday"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        BRBirthdayEditViewController *birthdayEditViewController = (BRBirthdayEditViewController *) navigationController.topViewController;
        birthdayEditViewController.birthday = self.birthday;
    }
}

@end
