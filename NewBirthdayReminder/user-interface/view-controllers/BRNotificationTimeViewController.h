//
//  BRNotificationTimeViewController.h
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/8/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRNotificationTimeViewController : BRCoreViewController

@property (weak, nonatomic) IBOutlet UIView *whatTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

- (IBAction)didChangeTime:(UIDatePicker *)sender;
@end
