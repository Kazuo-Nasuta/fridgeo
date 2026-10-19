//
//  ContentAddViewController.m
//  Fridgin
//
//  Created by 奈須田 一央 on 10/10/03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContentAddViewController.h"
#include "Content.h"
#include "Item.h"
#include "Storage.h"

@implementation ContentAddViewController

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = NSLocalizedString(@"Add Content", @"NavTitle");
    
    UIBarButtonItem *saveButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Save", @"BarButton")
										 style:UIBarButtonItemStyleDone
										target:self
										action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    [saveButtonItem release];

    UIBarButtonItem *cancelButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"BarButton")
										 style:UIBarButtonItemStyleBordered
										target:self
										action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];

	content.entryDate = [NSDate dateWithTimeIntervalSinceNow:0];
	[self setEditing:YES animated:NO];
}

- (void)addExtraButtons {
}

- (void)save {
	NSError *error = nil;
	if (![content.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	NSManagedObject* history = [NSEntityDescription insertNewObjectForEntityForName:@"History"
															 inManagedObjectContext:content.managedObjectContext];
	[history setValue:[NSDate dateWithTimeIntervalSinceNow:0] forKey:@"date"];
	[history setValue:NSLocalizedString(@"Add", @"HistoryVerb") forKey:@"verb"];
	[history setValue:NSLocalizedString(@"Content", @"HistoryObject") forKey:@"object"];
	[history setValue:content.item.name forKey:@"descr"];
	if (![history.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
 	[self.delegate contentAddView:self didAddContent:content];
}


- (void)cancel {
	[content.managedObjectContext deleteObject:content];
	
	NSError *error = nil;
	if (![content.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	
    [self.delegate contentAddView:self didAddContent:nil];
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
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return <#number of sections#>;
}
*/
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return <#number of rows in section#>;
}
*/
/*
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}
*/

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


#pragma mark -
#pragma mark Table view delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
//}

#pragma mark -
#pragma mark Memory management
/*
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}
*/
/*
- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}
*/
/*
- (void)dealloc {
    [super dealloc];
}
*/

- (void)itemSelectionViewController:(ItemSelectionViewController*)itemSelectionViewController didSelectItem:(Item *)item {
    if (item) {        
		NSDictionary* dict = [[self.arrayDataSource objectAtIndex:kSectionItem] objectAtIndex:kRowItem];
		UITableViewCell* tvcItem = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathItem length:2]];

		NSDictionary* dictStorage = [[self.arrayDataSource objectAtIndex:kSectionStorage] objectAtIndex:kRowStorage];
		UITableViewCell* tvcStorage = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathStorage length:2]];

		NSDictionary* dictQty = [[self.arrayDataSource objectAtIndex:kSectionQty] objectAtIndex:kRowQty];
		UITableViewCell* tvcQty = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathQty length:2]];

		NSDictionary* dictExpireDate = [[self.arrayDataSource objectAtIndex:kSectionExpireDate] objectAtIndex:kRowExpireDate];
		UITableViewCell* tvcExpireDate = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathExpireDate length:2]];
		
		content.item = item;
		tvcItem.detailTextLabel.text = content.item.name;
		[tvcItem setNeedsLayout];
		[dict setValue:item.name forKey:kDetailTextLabel];
		if (content.storage == nil) {
			content.storage = content.item.defaultStorage;
			tvcStorage.detailTextLabel.text = content.storage.name;
			[tvcStorage setNeedsLayout];
			[dictStorage setValue:tvcStorage.detailTextLabel.text forKey:kDetailTextLabel];
		}
		if (content.qty == nil) {
			content.qty = content.item.defaultQty;
			tvcQty.detailTextLabel.text = content.qty;
			[tvcQty setNeedsLayout];
			[dictQty setValue:tvcQty.detailTextLabel.text forKey:kDetailTextLabel];
		}
		if (content.expireDate == nil) {
			NSCalendar* gregorian = [NSCalendar autoupdatingCurrentCalendar];
			NSDateComponents* comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
												   fromDate:content.entryDate];
			NSInteger i = [comps day];
			[comps setDay:[comps day] + [content.item.defaultDurationDay integerValue]];
			[comps setMonth:[comps month] + [content.item.defaultDurationMonth integerValue]];
			[comps setYear:[comps year] + [content.item.defaultDurationYear integerValue]];
			i = [comps day];
			content.expireDate = [gregorian dateFromComponents:comps];
			tvcExpireDate.detailTextLabel.text = [dateFormatter stringFromDate:content.expireDate];
			[tvcExpireDate setNeedsLayout];
			[dictExpireDate setValue:tvcExpireDate.detailTextLabel.text forKey:kDetailTextLabel];
		}
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end

