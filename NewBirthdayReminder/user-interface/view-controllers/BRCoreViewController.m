//
//  BRCoreViewController.m
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/8/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRCoreViewController ()

@end

@implementation BRCoreViewController

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
	self.view.backgroundColor = [UIColor grayColor];
}

-(IBAction)cancelAndDismiss:(id)sender
{
    NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:^{
        // view controller simiss animation completed
    }];
}

-(IBAction)saveAndDismiss:(id)sender
{
    NSLog(@"Save");
    [self dismissViewControllerAnimated:YES completion:^{
        // view controller dismiss animation completed
    }];
}
@end
