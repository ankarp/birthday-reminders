//
//  BRBirthdayDetailViewController.h
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/8/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"

@interface BRBirthdayDetailViewController : BRCoreViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (nonatomic, strong) NSMutableDictionary *birthday;

@end
