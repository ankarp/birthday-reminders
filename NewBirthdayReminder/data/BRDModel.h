//
//  BRDModel.h
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/11/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRDModel : NSObject

+ (BRDModel *)sharedInstance;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
