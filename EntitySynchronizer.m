//
//  EntitySynchronizer.m
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/12/17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EntitySynchronizer.h"
#import "Storage.h"
#import "Item.h"

@interface EntitySynchronizer ()
- (Storage*)queryStorage:(NSString*)storagename;
@end


@implementation EntitySynchronizer
@synthesize window;
@synthesize managedObjectContext;
@synthesize frcStorage;
@synthesize frcItem;

- (void)storageWrite
{
	NSError* error;
	if (![[self frcStorage] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	NSArray* a = frcStorage.fetchedObjects;
	NSMutableArray* ma = [NSMutableArray arrayWithCapacity:[a count]];
	
	NSString *errorStr;
    //NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Storage.plist"];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Storage" ofType:@"plist"];
	
	for (int index = 0; index < [a count]; index ++) {
		Storage* storage = (Storage*)[a objectAtIndex:index];
		if (storage.thumbnailImage == nil) storage.thumbnailImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"noimage44" ofType:@"png"]];
		NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
								   [NSArray arrayWithObjects: storage.name, storage.durationFactor, UIImagePNGRepresentation(storage.thumbnailImage), nil]
															  forKeys:[NSArray arrayWithObjects: @"name", @"durationFactor", @"thumbnailImage", nil]];
		[ma addObject:plistDict];
	}
	NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:ma
																   format:NSPropertyListXMLFormat_v1_0
														 errorDescription:&errorStr];
	if(plistData) {
		[plistData writeToFile:plistPath atomically:YES];
	}
	else {
		NSLog(errorStr, nil);
		[errorStr release];
	}
	
	
}

- (void)storageRead
{
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSString *plistPath;
	//	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
	//															  NSUserDomainMask, YES) objectAtIndex:0];
	//	plistPath = [rootPath stringByAppendingPathComponent:@"Storage.plist"];
	//	if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
	//	plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
	//	}
	plistPath = [[NSBundle mainBundle] pathForResource:@"Storage" ofType:@"plist"];
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	NSArray *a = (NSArray *)[NSPropertyListSerialization
							 propertyListFromData:plistXML
							 mutabilityOption:NSPropertyListMutableContainersAndLeaves
							 format:&format
							 errorDescription:&errorDesc];
	NSError* error;
	for (int index = 0; index < [a count]; index ++) {
		NSDictionary *temp = (NSDictionary *)[a objectAtIndex:index];
		if (!temp) {
			NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
		}
		Storage* storage = [NSEntityDescription insertNewObjectForEntityForName:@"Storage"
														 inManagedObjectContext:self.managedObjectContext];
		storage.name = [temp objectForKey:@"name"];
		storage.durationFactor = [temp objectForKey:@"durationFactor"];
		storage.thumbnailImage =  [[UIImage alloc] initWithData:[temp objectForKey:@"thumbnailImage"]];
		if (![self.managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

- (void)itemWrite
{
	NSError* error;
	if (![[self frcItem] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	NSArray* a = frcItem.fetchedObjects;
	NSMutableArray* ma = [NSMutableArray arrayWithCapacity:[a count]];
	
	NSString *errorStr;
	//    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	//    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Item.plist"];
	NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Item" ofType:@"plist"];
	
	for (int index = 0; index < [a count]; index ++) {
		Item* item = (Item*)[a objectAtIndex:index];
		if (item.defaultDurationDay == nil) item.defaultDurationDay = [NSNumber numberWithInt:0];
		if (item.defaultDurationMonth == nil) item.defaultDurationMonth = [NSNumber numberWithInt:0];
		if (item.defaultDurationYear == nil) item.defaultDurationYear = [NSNumber numberWithInt:0];
		if (item.defaultQty == nil) item.defaultQty = @"1pcs.";
		if (item.defaultStorage.name == nil) item.defaultStorage.name = @"";
		if (item.thumbnailImage == nil) item.thumbnailImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"noimage44" ofType:@"png"]];
		NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
								   [NSArray arrayWithObjects: item.name, item.section, item.defaultStorage.name, item.defaultQty, item.defaultDurationDay, item.defaultDurationMonth, item.defaultDurationYear, UIImagePNGRepresentation(item.thumbnailImage), nil]
															  forKeys:[NSArray arrayWithObjects: @"name", @"section", @"defaultStorage", @"defaultQty", @"defaultDurationDay", @"defaultDurationMonth", @"defaultDurationYear", @"thumbnailImage", nil]];
		[ma addObject:plistDict];
	}
	NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:ma
																   format:NSPropertyListXMLFormat_v1_0
														 errorDescription:&errorStr];
	if(plistData) {
		[plistData writeToFile:plistPath atomically:YES];
	}
	else {
		NSLog(errorStr, nil);
		[errorStr release];
	}
	
	
}

- (void)itemRead
{
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Item" ofType:@"plist"];
	//NSString *plistPath;
	//	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
	//															  NSUserDomainMask, YES) objectAtIndex:0];
	//	plistPath = [rootPath stringByAppendingPathComponent:@"Item.plist"];
	//	if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
	//		plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
	//	}
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	NSArray *a = (NSArray *)[NSPropertyListSerialization
							 propertyListFromData:plistXML
							 mutabilityOption:NSPropertyListMutableContainersAndLeaves
							 format:&format
							 errorDescription:&errorDesc];
	NSError* error;
	for (int index = 0; index < [a count]; index ++) {
		NSDictionary *temp = (NSDictionary *)[a objectAtIndex:index];
		if (!temp) {
			NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
		}
		Item* item = [NSEntityDescription insertNewObjectForEntityForName:@"Item"
												   inManagedObjectContext:self.managedObjectContext];
		item.name = [temp objectForKey:@"name"];
		item.section = [temp objectForKey:@"section"];
		item.defaultStorage = [self queryStorage:[temp objectForKey:@"defaultStorage"]];
		item.defaultQty = [temp objectForKey:@"defaultQty"];
		item.defaultDurationDay = [temp objectForKey:@"defaultDurationDay"];
		item.defaultDurationMonth = [temp objectForKey:@"defaultDurationMonth"];
		item.defaultDurationYear = [temp objectForKey:@"defaultDurationYear"];
		item.thumbnailImage =  [[UIImage alloc] initWithData:[temp objectForKey:@"thumbnailImage"]];
		if (![self.managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

- (Storage*)queryStorage:(NSString*)storagename
{
	Storage* ret = nil;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Storage"
											  inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", storagename];
	
	[fetchRequest setPredicate:predicate];
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
	// nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController =
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
										managedObjectContext:self.managedObjectContext
										  sectionNameKeyPath:nil cacheName:@"Storagename"];
	NSError* error;
	if (![aFetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	NSArray* a = aFetchedResultsController.fetchedObjects;
	if ([a count] != 0) {
		ret = [a objectAtIndex:0];
	}
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	return ret;
}

- (NSFetchedResultsController *)frcStorage {
    // Set up the fetched results controller if needed.
    if (frcStorage == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"Storage"
												  inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController =
		[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											managedObjectContext:managedObjectContext
											  sectionNameKeyPath:nil cacheName:@"StorageWrite"];
        //aFetchedResultsController.delegate = self;
        self.frcStorage = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return frcStorage;
}    

- (NSFetchedResultsController *)frcItem {
    // Set up the fetched results controller if needed.
    if (frcItem == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
		NSEntityDescription *entity =
		[NSEntityDescription entityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = 
		[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											managedObjectContext:managedObjectContext
											  sectionNameKeyPath:nil cacheName:@"ItemWrite"];
        //aFetchedResultsController.delegate = self;
        self.frcItem = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return frcItem;
}


@end
