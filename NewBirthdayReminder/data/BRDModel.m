//
//  BRDModel.m
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/11/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import "BRDModel.h"

@implementation BRDModel

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static BRDModel *_sharedInstance = nil;
+ (BRDModel *)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[BRDModel alloc] init];
    }
    return _sharedInstance;
}

-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    NSLog(@"coordinator: %@", coordinator);
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }

    // NOTE IMPORTANT: resource has to match base of .xcdatamodeld file
    // ALSO: if created project without Core Data enabled, then MUST:
    // 1. choose .xcdatamodel file
    // 2. Editor->Add Model Version->[Create]
    // (this resulted in creation of "BirthdayReminder 2.xcdatamodel" file, and then it all worked.
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BirthdayReminder" withExtension:@"momd"];
    NSLog(@"modelURL: %@", modelURL);
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSLog(@"returning mangedObjectModel: %@", _managedObjectContext);
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NewBirthdayReminder.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
