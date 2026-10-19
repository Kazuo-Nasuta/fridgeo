//
//  SettingsViewController.m
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "DBTableLaunchViewController.h"
#import "Storage.h"
#import "Item.h"
#import "EntitySynchronizer.h"

#define kStdButtonWidth		66.0
//#define kStdButtonHeight	40.0
#define kStdButtonHeight	35.0
#define kViewTag			1		// for tagging our embedded controls for removal at cell recycle time

//static NSString* kSectionTitle = @"kSectionTitle";
static NSString* kCellIdentifier = @"kCellIdentifier";
static NSString* kTextLabel = @"kTextLabel";
//static NSString* kDetailTextLabel = @"kDetailTextLabel";
static NSString* kSubView = @"kSubView";
//static NSString* kEditingAccessoryType = @"kEditingAccessoryType";
static NSString* kDidSelectRow = @"kDidSelectRow";
static NSString* kAction = @"kAction";


const NSUInteger kSectionDropbox = 0;
const NSUInteger kRowDropbox = 0;
NSUInteger kPathDropbox[] = {0, 0};
const NSUInteger kSectionStorageWrite = 1;
const NSUInteger kRowStorageWrite = 0;
NSUInteger kPathStorageWrite[] = {1, 0};
const NSUInteger kSectionStorageRead = 2;
const NSUInteger kRowStorageRead = 0;
NSUInteger kPathStorageRead[] = {2, 0};
const NSUInteger kSectionItemWrite = 3;
const NSUInteger kRowItemWrite = 0;
NSUInteger kPathItemWrite[] = {3, 0};
const NSUInteger kSectionItemRead = 4;
const NSUInteger kRowItemRead = 0;
NSUInteger kPathItemRead[] = {4, 0};
const NSUInteger kSectionClearHistory = 5;
const NSUInteger kRowClearHistory = 0;
NSUInteger kPathClearHistory[] = {5, 0};


@implementation SettingsViewController

@synthesize fetchedResultsController;
@synthesize controllerItem;
@synthesize managedObjectContext;
@synthesize btnDropbox;
@synthesize btnStorageWrite;
@synthesize btnStorageRead;
@synthesize btnItemWrite;
@synthesize btnItemRead;
@synthesize arrayDataSource;
@synthesize entitySynchronizer;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.arrayDataSource = [NSArray arrayWithObjects:
							[NSArray arrayWithObjects:
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Dropbox", kCellIdentifier,
							  NSLocalizedString(@"Dropbox", @"TextLabel"), kTextLabel,
							  self.btnDropbox, kSubView,
							  @"dropbox", kDidSelectRow,
							  //@"dropbox", kAction,
							  nil],
							 nil],
							[NSArray arrayWithObjects:
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Write Storage List to Plist", kCellIdentifier,
							  NSLocalizedString(@"Write Storage List to Plist", @"TextLabel"), kTextLabel,
							  self.btnStorageWrite, kSubView,
							  @"alertStorageWrite", kDidSelectRow,
							  @"storageWrite", kAction,
							  nil],
							 nil],
							[NSArray arrayWithObjects:
 							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Read Storage List from Plist", kCellIdentifier,
							  NSLocalizedString(@"Read Storage List from Plist", @"TextLabel"), kTextLabel,
							  self.btnStorageRead, kSubView,
							  @"alertStorageRead", kDidSelectRow,
							  @"storageRead", kAction,
							  nil],
							 nil],
							[NSArray arrayWithObjects:
 							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Write Item List to Plist", kCellIdentifier,
							  NSLocalizedString(@"Write Item List to Plist", @"TextLabel"), kTextLabel,
							  self.btnItemWrite, kSubView,
							  @"alertItemWrite", kDidSelectRow,
							  @"itemWrite", kAction,
							  nil],
							 nil],
							[NSArray arrayWithObjects:
 							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Read Item List from Plist", kCellIdentifier,
							  NSLocalizedString(@"Read Item List from Plist", @"TextLabel"), kTextLabel,
							  self.btnItemRead, kSubView,
							  @"alertItemRead", kDidSelectRow,
							  @"itemRead", kAction,
							  nil],
							 nil],
							[NSArray arrayWithObjects:
 							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Clear History", kCellIdentifier,
							  NSLocalizedString(@"Clear History", @"TextLabel"), kTextLabel,
							  @"alertClearHistory", kDidSelectRow,
							  @"clearHistory", kAction,
							  nil],
							 nil],
							nil];
	entitySynchronizer = [[EntitySynchronizer alloc] init];
	[entitySynchronizer setManagedObjectContext:managedObjectContext];
	[entitySynchronizer setWindow:self.view.window];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.arrayDataSource count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSArray* array = [self.arrayDataSource objectAtIndex:section];
	return [array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray* array = [self.arrayDataSource objectAtIndex:indexPath.section];
	NSDictionary* dict = [array objectAtIndex:indexPath.row];
    NSString *CellIdentifier = [dict valueForKey:kCellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:CellIdentifier] autorelease];
    }
	else
	{
		// the cell is being recycled, remove old embedded controls
		UIView *viewToRemove = nil;
		viewToRemove = [cell.contentView viewWithTag:kViewTag];
		if (viewToRemove)
			[viewToRemove removeFromSuperview];
	}
	
	cell.textLabel.text = [dict valueForKey:kTextLabel];
	//[cell.contentView addSubview:[dict valueForKey:kSubView]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray* array = [self.arrayDataSource objectAtIndex:indexPath.section];
	NSDictionary* dict = [array objectAtIndex:indexPath.row];
	SEL sel = NSSelectorFromString([dict valueForKey:kDidSelectRow]);
	if (sel) {
		[self performSelector:sel];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[entitySynchronizer release];
	[btnStorageWrite release];
    [super dealloc];
}


- (UIButton *)btnDropbox
{
	if (btnDropbox == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		btnDropbox = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		btnDropbox.frame = CGRectMake(222.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		[btnDropbox setTitle:@"OK" forState:UIControlStateNormal];
		btnDropbox.backgroundColor = [UIColor clearColor];
		[btnDropbox addTarget:self action:@selector(dropbox) forControlEvents:UIControlEventTouchUpInside];
		
		btnDropbox.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return btnDropbox;
}

- (UIButton *)btnStorageWrite
{
	if (btnStorageWrite == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		btnStorageWrite = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		btnStorageWrite.frame = CGRectMake(222.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		[btnStorageWrite setTitle:@"OK" forState:UIControlStateNormal];
		btnStorageWrite.backgroundColor = [UIColor clearColor];
		[btnStorageWrite addTarget:self action:@selector(storageWrite) forControlEvents:UIControlEventTouchUpInside];
		
		btnStorageWrite.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return btnStorageWrite;
}

- (UIButton *)btnStorageRead
{
	if (btnStorageRead == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		btnStorageRead = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		btnStorageRead.frame = CGRectMake(222.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		[btnStorageRead setTitle:@"OK" forState:UIControlStateNormal];
		btnStorageRead.backgroundColor = [UIColor clearColor];
		[btnStorageRead addTarget:self action:@selector(storageRead) forControlEvents:UIControlEventTouchUpInside];
		
		btnStorageRead.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return btnStorageRead;
}

- (UIButton *)btnItemWrite
{
	if (btnItemWrite == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		btnItemWrite = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		btnItemWrite.frame = CGRectMake(222.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		[btnItemWrite setTitle:@"OK" forState:UIControlStateNormal];
		btnItemWrite.backgroundColor = [UIColor clearColor];
		[btnItemWrite addTarget:self action:@selector(itemWrite) forControlEvents:UIControlEventTouchUpInside];
		
		btnItemWrite.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return btnItemWrite;
}

- (UIButton *)btnItemRead
{
	if (btnItemRead == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		btnItemRead = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		btnItemRead.frame = CGRectMake(222.0, 5.0, kStdButtonWidth, kStdButtonHeight);
		[btnItemRead setTitle:@"OK" forState:UIControlStateNormal];
		btnItemRead.backgroundColor = [UIColor clearColor];
		[btnItemRead addTarget:self action:@selector(itemRead) forControlEvents:UIControlEventTouchUpInside];
		
		btnItemRead.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
	}
	return btnItemRead;
}

- (void)dropbox
{
	DBTableLaunchViewController* dbv = [DBTableLaunchViewController alloc];
	[dbv initWithNibName:@"DBTableLaunchView" bundle:nil];
    //NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	//iev.item = (Item*)managedObject;
    [self.navigationController pushViewController:dbv animated:YES];
	[dbv release];
}

- (void)storageWrite
{
	[entitySynchronizer storageWrite];
}

- (void)storageRead
{
	[entitySynchronizer storageRead];
}

- (void)itemWrite
{
	[entitySynchronizer itemWrite];
}

- (void)itemRead
{
	[entitySynchronizer itemRead];
}

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
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
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return fetchedResultsController;
}    

- (NSFetchedResultsController *)controllerItem {
    // Set up the fetched results controller if needed.
    if (controllerItem == nil) {
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
        self.controllerItem = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return controllerItem;
}

#pragma mark -
#pragma mark UIAlertView

- (void)alertStorageWrite {
	// open a alert with an OK and cancel button
	NSArray* array = [self.arrayDataSource objectAtIndex:kSectionStorageWrite];
	NSDictionary* dict = [array objectAtIndex:kRowStorageWrite];
    NSString *title = [dict valueForKey:kTextLabel];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:nil
												   delegate:self
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertStorageRead {
	// open a alert with an OK and cancel button
	NSArray* array = [self.arrayDataSource objectAtIndex:kSectionStorageRead];
	NSDictionary* dict = [array objectAtIndex:kRowStorageRead];
    NSString *title = [dict valueForKey:kTextLabel];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:NSLocalizedString(@"NOTE:Data may be duplicated.", @"AlertMessage")
												   delegate:self
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertItemWrite {
	// open a alert with an OK and cancel button
	NSArray* array = [self.arrayDataSource objectAtIndex:kSectionItemWrite];
	NSDictionary* dict = [array objectAtIndex:kRowItemWrite];
    NSString *title = [dict valueForKey:kTextLabel];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:nil
												   delegate:self
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertItemRead {
	// open a alert with an OK and cancel button
	NSArray* array = [self.arrayDataSource objectAtIndex:kSectionItemRead];
	NSDictionary* dict = [array objectAtIndex:kRowItemRead];
    NSString *title = [dict valueForKey:kTextLabel];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:NSLocalizedString(@"NOTE:Data may be duplicated.", @"AlertMessage")
												   delegate:self
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	BOOL bBreak = NO;
	if (buttonIndex) {
		// search array and find corresponding dictionary with alertview title
		for (int section = 0; section < [self.arrayDataSource count]; section++) {
			NSArray* array = [self.arrayDataSource objectAtIndex:section];
			for (int row = 0; row < [array count]; row ++) {
				NSDictionary* dict = [array objectAtIndex:row];
				if ([actionSheet.title compare:[dict valueForKey:kTextLabel]] == NSOrderedSame) {
					SEL sel = NSSelectorFromString([dict valueForKey:kAction]);
					if (sel) {
						[self performSelector:sel];
					}
					bBreak = YES;
					break;
				}
			}
			if (bBreak) {
				break;
			}
		}
	}
}

- (void)alertClearHistory {
	// open a alert with an OK and cancel button
	NSArray* array = [self.arrayDataSource objectAtIndex:kSectionClearHistory];
	NSDictionary* dict = [array objectAtIndex:kRowClearHistory];
    NSString *title = [dict valueForKey:kTextLabel];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:nil
												   delegate:self
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)clearHistory {
	NSError* error;
	// Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"History"
											  inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
       
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = 
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
										managedObjectContext:managedObjectContext
										  sectionNameKeyPath:nil cacheName:@"History_"];

	if (![aFetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}

	NSArray* a = aFetchedResultsController.fetchedObjects;
	for (int i = 0; i < [a count]; i ++) {
		[self.managedObjectContext deleteObject:[a objectAtIndex:i]];
	}

	if (![self.managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
}


@end

