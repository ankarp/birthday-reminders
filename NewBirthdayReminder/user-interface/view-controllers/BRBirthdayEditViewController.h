//
//  BRBirthdayEditViewController.h
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/8/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"

@interface BRBirthdayEditViewController : BRCoreViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *includeYearLabel;
@property (weak, nonatomic) IBOutlet UISwitch *includeYearSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)didChangeNameText:(UITextField *)sender;
- (IBAction)didToggleSwitch:(UISwitch *)sender;
- (IBAction)didChangeDatePicker:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet UIView *phtoContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *picPhotoLabel;
- (IBAction)didTapPhoto:(UITapGestureRecognizer *)sender;

@end
