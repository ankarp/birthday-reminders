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

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateSaveButton];
    
}

-(void) updateSaveButton
{
    self.saveButton.enabled = self.nameTextField.text.length > 0;
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextField resignFirstResponder];
    return NO;
}

- (IBAction)didChangeNameText:(UITextField *)sender {
    NSLog(@"The text was changed: %@", self.nameTextField.text);
    [self updateSaveButton];
}

- (IBAction)didToggleSwitch:(UISwitch *)sender {
    if (self.includeYearSwitch.on) {
        NSLog(@"Sure, I'll share my age with you");
    } else {
        NSLog(@"I'd prefer to keep my age to myself");
    }
}

- (IBAction)didChangeDatePicker:(UIDatePicker *)sender {
    NSLog(@"New Birthdate selected: %@", self.datePicker.date);
}

- (IBAction)didTapPhoto:(UITapGestureRecognizer *)sender {
    NSLog(@"Did Tap Photo!");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"No camera detected!");
        return;
    }

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo", @"Pick from Photo Library", nil];
    [actionSheet showInView:self.view];
}
@end
