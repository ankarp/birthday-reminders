//
//  BRDBirthday.m
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/10/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import "BRDBirthday.h"


@implementation BRDBirthday

@dynamic birthDay;
@dynamic addressBookID;
@dynamic birthMonth;
@dynamic birthYear;
@dynamic facebookID;
@dynamic imageData;
@dynamic name;
@dynamic nextBirthday;
@dynamic nextBirthdayAge;
@dynamic notes;
@dynamic picURL;
@dynamic uid;

-(void)updateNextBirthdayAndAge
{
    NSDate *now = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    NSDate *today = [calendar dateFromComponents:dateComponents];

    dateComponents.day = [self.birthDay intValue];
    dateComponents.month = [self.birthMonth intValue];

    NSDate *birthdayThisYear = [calendar dateFromComponents:dateComponents];

    if ([today compare:birthdayThisYear] == NSOrderedDescending) {
        // birthday this year passed sp next birthday will ne next year
        dateComponents.year++;
        self.nextBirthday = [calendar dateFromComponents:dateComponents];
    } else {
        self.nextBirthday = [birthdayThisYear copy];
    }

    if ([self.birthYear intValue] > 0) {
        self.nextBirthdayAge = [NSNumber numberWithInt:dateComponents.year - [self.birthYear intValue]];
    } else {
        self.nextBirthdayAge = [NSNumber numberWithInt:0];
    }
}

-(void)updateWithDefaults
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];

    self.birthDay = @(dateComponents.day);
    self.birthMonth = @(dateComponents.month);
    self.birthYear = @(0);

    [self updateNextBirthdayAndAge];
}

-(int) remainingDaysUntilNextBirthday
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToday = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    NSDate *today = [calendar dateFromComponents:componentsToday];

    NSTimeInterval timeDiffSecs = [self.nextBirthday timeIntervalSinceDate:today];

    int days = floor(timeDiffSecs / (60.f*60.f*24.f));

    return days;
}

-(BOOL) isBirthdayToday
{
    return [self remainingDaysUntilNextBirthday] == 0;
}

-(NSString *)birthdayTextToDisplay
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToday = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    NSDate *today = [calendar dateFromComponents:componentsToday];

    NSDateComponents *components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today toDate:self.nextBirthday options:0];

    if (components.month == 0) {
        if (components.day == 0) {
            // today!

            if ([self.nextBirthdayAge intValue] > 0) {
                return [NSString stringWithFormat:@"%@ Today!", self.nextBirthdayAge];
            } else {
                return @"Today!";
            }
        }
        if (components.day == 1) {
            // tomorrow!
            if ([self.nextBirthdayAge intValue] > 0) {
                return [NSString stringWithFormat:@"%@ Tomorrow!", self.nextBirthdayAge];
            } else {
                return @"Tomorrow!";
            }
        }
    }

    NSString *text = @"";

    if ([self.nextBirthdayAge intValue] > 0) {
        text = [NSString stringWithFormat:@"%@ on ", self.nextBirthdayAge];
    }

    static NSDateFormatter *dateFormatterPartial;

    if (dateFormatterPartial == nil) {
        dateFormatterPartial = [[NSDateFormatter alloc] init];
        [dateFormatterPartial setDateFormat:@"MMM d"];
    }

    return [text stringByAppendingFormat:@"%@", [dateFormatterPartial stringFromDate:self.nextBirthday]];
}

@end
