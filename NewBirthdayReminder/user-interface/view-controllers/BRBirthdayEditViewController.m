//
//  BRBirthdayEditViewController.m
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/8/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import "BRBirthdayEditViewController.h"

@interface BRBirthdayEditViewController ()

@end

@implementation BRBirthdayEditViewController

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

- (IBAction)cancelAndDismiss:(UIBarButtonItem *)sender {
    NSLog(@"Cancel!");
    [self dismissViewControllerAnimated:YES completion:^{
        // any code we place inside this block will
        // run once the view controller has been dismissed
        NSLog(@"Dismiss complete!");
    }];
}
@end
