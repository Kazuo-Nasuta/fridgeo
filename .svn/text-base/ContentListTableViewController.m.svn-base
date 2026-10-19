//
//  ContentListTableView.m
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContentListTableViewController.h"
#import "Item.h"
#import "Storage.h"
#import "ContentTableViewCell.h"

/*
 @interface ContentListTableViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end
*/

@implementation ContentListTableViewController
@synthesize fetchedResultsController, managedObjectContext;
@synthesize seg;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	// navigation bar buttons
	[super viewDidLoad];
	
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton =
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
													   target:self
													   action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];

	// segment control on navigation bar
	seg = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
											  NSLocalizedString(@"by Storage", @"Seg"),
											  NSLocalizedString(@"ExpireDate", @"Seg"),
											  NSLocalizedString(@"EntryDate", @"Seg"),
												nil ]];
	seg.selectedSegmentIndex = 0;
	seg.segmentedControlStyle = UISegmentedControlStyleBar;
	[seg addTarget:self action:@selector(segValueChanged) forControlEvents:UIControlEventValueChanged];
	self.navigationItem.titleView = seg;

	// table view title
	CGRect rcFrame = {{0,0},{320,20}};
	UIView* v = [[UIView alloc] initWithFrame:rcFrame];
	UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a0024_000086.jpg"]];
	[v addSubview:iv];
	UILabel* label = [[UILabel alloc] initWithFrame:rcFrame];
	label.text = NSLocalizedString(@"Fridgeo - Manage Contents of Food Storage", @"ContentHeader");
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor grayColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textAlignment = UITextAlignmentCenter;
	label.backgroundColor = [UIColor clearColor];
	[v addSubview:label];
	v.clipsToBounds = YES;
	self.tableView.tableHeaderView = v;
	[v release];
	[iv release];
	[label release];
}

- (void)segValueChanged {
	[self viewWillDisappear:YES];
	[self viewWillAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	[self.tableView reloadData];
	[super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.fetchedResultsController = nil;
}

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
/*
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	//    cell.textLabel.text = [[managedObject valueForKey:@"name"] description];
	//NSString* str = [managedObject valueForKey:@"name"];
	Item* item = [managedObject valueForKey:@"item"];
	cell.textLabel.text = item.name;
}
*/

#pragma mark -
#pragma mark Table view data source

- (void)insertNewObject:(id)sender {
	// To add a new recipe, create a RecipeAddViewController.  Present it as a modal view so that the user's focus is on the task of adding the recipe; wrap the controller in a navigation controller to provide a navigation bar for the Done and Save buttons (added by the RecipeAddViewController in its viewDidLoad method).
    ContentAddViewController *addController = [ContentAddViewController alloc];
	addController.managedObjectContext = self.managedObjectContext;
    addController.delegate = self;
	
	Content *newContent = [NSEntityDescription insertNewObjectForEntityForName:@"Content"
														inManagedObjectContext:self.managedObjectContext];
	addController.content = newContent;
	
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
	[addController initWithNibName:@"ContentDetailView" bundle:nil];
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [addController release];
}

- (void)contentAddView:(ContentDetailViewController *)contentAddView didAddContent:(Content *)content {
    if (content) {        
   }
    
    // Dismiss the modal add recipe view controller
    [self dismissModalViewControllerAnimated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [[fetchedResultsController sections] count];
    return count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
	
    if ([[fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}

/*
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	//NSString* temp = [[managedObject valueForKey:@"name"] description];
	//cell.textLabel.text = temp;
	Item* item = [managedObject valueForKey:@"item"];
	cell.textLabel.text = item.name;
	
    return cell;
}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dequeue or if necessary create a RecipeTableViewCell, then set its recipe to the recipe for the current row.
    static NSString *ContentCellIdentifier = @"ContentCellIdentifier";
    
    ContentTableViewCell *contentCell = (ContentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ContentCellIdentifier];
    if (contentCell == nil) {
        contentCell = [[[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ContentCellIdentifier] autorelease];
		contentCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
	[self configureCell:contentCell atIndexPath:indexPath];
    
    return contentCell;
}


- (void)configureCell:(ContentTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
	Content* content = (Content *)[fetchedResultsController objectAtIndexPath:indexPath];
    cell.content = content;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString* ret = @"";
	NSArray* sections = [self.fetchedResultsController sections];
	if ([sections count]) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
		ret = [sectionInfo name];
	}
	return ret;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath) {
		if (editingStyle == UITableViewCellEditingStyleDelete) {
			// Delete the managed object for the given index path
			NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
			[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
			// Save the context.
			NSError *error = nil;
			if (![context save:&error]) {
				/*
				 Replace this implementation with code to handle the error appropriately.
            
				 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
				 */
				NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				abort();
			}
		}
	}
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self showDetail:indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	[self showDetail:indexPath];
}

- (void)showDetail:(NSIndexPath *)indexPath {
	ContentDetailViewController* cdv = [ContentDetailViewController alloc];
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	[cdv initWithNibName:@"ContentDetailView" bundle:nil];
	cdv.content = (Content*)managedObject;
	cdv.delegate = self;
    [self.navigationController pushViewController:cdv animated:YES];
	[cdv release];

}

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
		NSString* snkPath;
		NSSortDescriptor *sd = nil;
		
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"Content"
												  inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        // Edit the sort key as appropriate.
		if (seg.selectedSegmentIndex == 0) {
			sd = [[NSSortDescriptor alloc] initWithKey:@"storage.name" ascending:YES];
			snkPath = @"storage.name";
		} else if (seg.selectedSegmentIndex == 1) {
			sd = [[NSSortDescriptor alloc] initWithKey:@"expireDate" ascending:YES];
			snkPath = @"expireStr";
		} else {
			sd = [[NSSortDescriptor alloc] initWithKey:@"entryDate" ascending:YES];
			snkPath = @"entryStr";
		}
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sd, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = 
		[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											managedObjectContext:managedObjectContext
											  sectionNameKeyPath:snkPath
													   cacheName:@"ContentList"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sd release];
        [sortDescriptors release];
    }
	return fetchedResultsController;
}    

#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
		{
			ContentTableViewCell* cell = (ContentTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
			NSString* str = cell.nameLabel.text;
			NSManagedObject* history = [NSEntityDescription insertNewObjectForEntityForName:@"History"
																	 inManagedObjectContext:self.managedObjectContext];
			[history setValue:[NSDate dateWithTimeIntervalSinceNow:0] forKey:@"date"];
			[history setValue:NSLocalizedString(@"Delete", @"HistoryVerb") forKey:@"verb"];
			[history setValue:NSLocalizedString(@"Content", @"HistoryObject") forKey:@"object"];
			[history setValue:str forKey:@"descr"];
			NSError* error;
			if (![history.managedObjectContext save:&error]) {
				/*
				 Replace this implementation with code to handle the error appropriately.
				 
				 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
				 */
				NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				abort();
			}		
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(ContentTableViewCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */


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
	[seg release];
}


- (void)dealloc {
	[seg release];
    [super dealloc];
}

@end

