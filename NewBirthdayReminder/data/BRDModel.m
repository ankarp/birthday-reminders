//
//  BRDModel.m
//  NewBirthdayReminder
//
//  Created by Jennnifer Karp on 2/11/14.
//  Copyright (c) 2014 tolikarp. All rights reserved.
//

#import "BRDModel.h"
#import "BRDBirthday.h"

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

-(void)saveChanges
{
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges]) {
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Save failed: %@", [error localizedDescription]);
        } else {
            NSLog(@"Save succeded");
        }
    }
}

-(NSMutableDictionary *)getExistingBirthdatsWithUIDs:(NSArray *)uids
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid IN %@", uids];
    fetchRequest.predicate = predicate;

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BRDBirthday" inManagedObjectContext:context];
    fetchRequest.entity = entity;

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    fetchRequest.sortDescriptors = sortDescriptors;

    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];

    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    NSArray *fetchedObjects = fetchedResultsController.fetchedObjects;

    NSInteger resultCount = [fetchedObjects count];

    if (resultCount == 0) {
        return [NSMutableDictionary dictionary];
    }

    BRDBirthday *birthday;
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
    int i;

    for (i = 0; i < resultCount; i++) {
        birthday = fetchedObjects[i];
        tmpDict[birthday.uid] = birthday;
    }

    return tmpDict;
}


#pragma mark - Application's Documents directory
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
