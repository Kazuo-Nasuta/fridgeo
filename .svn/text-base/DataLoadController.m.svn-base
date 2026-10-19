    //
//  DataLoadController.m
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/11/03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataLoadController.h"
#import "Item.h"
#import "Storage.h"

@implementation DataLoadController
@synthesize context;
@synthesize pv;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.view.backgroundColor = [UIColor blackColor];
	self.view.alpha = 0.7;

	CGRect rc = {{self.view.bounds.origin.x + 10, self.view.center.y}, {self.view.bounds.size.width - 20, 40}};
	pv = [[UIProgressView alloc] initWithFrame:rc];
	pv.progressViewStyle= UIProgressViewStyleDefault;
	[self.view addSubview:pv];
	pv.progress = 0;

	CGRect rcLabel = {{self.view.bounds.origin.x + 10, self.view.center.y - 40}, {self.view.bounds.size.width - 20, 40}};
	UILabel* label = [[UILabel alloc] initWithFrame:rcLabel];
	label.text = NSLocalizedString(@"Loading Data...", @"LoadingMsg");
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor grayColor];
	label.font = [UIFont boldSystemFontOfSize:16];
	label.textAlignment = UITextAlignmentCenter;
	label.backgroundColor = [UIColor clearColor];
	[self.view addSubview:label];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self performSelectorInBackground:@selector(progressWindow) withObject:nil];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [pv release];
	[context release];
	[super dealloc];
}

- (void)progressWindow {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	[self storageRead:context];
	[self itemRead:context];
	[pool release];
}

- (void)storageRead:(NSManagedObjectContext*)moc
{
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSString *plistPath;
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
														 inManagedObjectContext:moc];
		storage.name = [temp objectForKey:@"name"];
		storage.durationFactor = [temp objectForKey:@"durationFactor"];
		storage.thumbnailImage =  [[UIImage alloc] initWithData:[temp objectForKey:@"thumbnailImage"]];
		if (![moc save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

- (void)itemRead:(NSManagedObjectContext*)moc
{
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Item" ofType:@"plist"];
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
												   inManagedObjectContext:moc];
		item.name = [temp objectForKey:@"name"];
		item.section = [temp objectForKey:@"section"];
		item.defaultStorage = [self queryStorage:[temp objectForKey:@"defaultStorage"] managedObjectContext:moc];
		item.defaultQty = [temp objectForKey:@"defaultQty"];
		item.defaultDurationDay = [temp objectForKey:@"defaultDurationDay"];
		item.defaultDurationMonth = [temp objectForKey:@"defaultDurationMonth"];
		item.defaultDurationYear = [temp objectForKey:@"defaultDurationYear"];
		item.thumbnailImage =  [[UIImage alloc] initWithData:[temp objectForKey:@"thumbnailImage"]];
		if (![moc save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
		[self performSelectorInBackground:@selector(progress:) withObject:[NSNumber numberWithFloat:(float) index / (float) [a count]]];
	}
	[self.view removeFromSuperview];
	[self.view release];
	self.view = nil;
	//[self dismissModalViewControllerAnimated:YES];
}

- (Storage*)queryStorage:(NSString*)storagename managedObjectContext:(NSManagedObjectContext*)moc
{
	Storage* ret = nil;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Storage"
											  inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	
	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", storagename];
	
	[fetchRequest setPredicate:predicate];
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSFetchedResultsController *aFetchedResultsController =
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
										managedObjectContext:moc
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

- (void)progress:(NSNumber *)p {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	pv.progress = [p floatValue];
	[pool release];
}



@end
