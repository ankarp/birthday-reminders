//
//  BRDBirthday.h
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/10/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BRDBirthday : NSManagedObject

@property (nonatomic, retain) NSNumber * birthDay;
@property (nonatomic, retain) NSNumber * addressBookID;
@property (nonatomic, retain) NSNumber * birthMonth;
@property (nonatomic, retain) NSNumber * birthYear;
@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * nextBirthday;
@property (nonatomic, retain) NSNumber * nextBirthdayAge;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * picURL;
@property (nonatomic, retain) NSString * uid;

@property (nonatomic, readonly) int remainingDaysUntilNextBirthday;
@property (nonatomic, readonly) NSString *birthdayTextToDisplay;
@property (nonatomic, readonly) BOOL isBirthdayToday;

-(void)updateNextBirthdayAndAge;
-(void)updateWithDefaults;

@end
