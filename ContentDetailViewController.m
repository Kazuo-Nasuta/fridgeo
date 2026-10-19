//
//  ContentAddView.m
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContentDetailViewController.h"
#import "Content.h"
#import "Item.h"
#import "Storage.h"

const NSUInteger kSectionItem = 0;
const NSUInteger kRowItem = 0;
NSUInteger kPathItem[] = {0, 0};
const NSUInteger kSectionStorage = 0;
const NSUInteger kRowStorage = 1;
NSUInteger kPathStorage[] = {0, 1};
const NSUInteger kSectionQty = 0;
const NSUInteger kRowQty = 2;
NSUInteger kPathQty[] = {0, 2};
const NSUInteger kSectionEntryDate = 0;
const NSUInteger kRowEntryDate = 3;
NSUInteger kPathEntryDate[] = {0, 3};
const NSUInteger kSectionExpireDate = 0;
const NSUInteger kRowExpireDate = 4;
NSUInteger kPathExpireDate[] = {0, 4};


NSString* kCellIdentifier = @"kCellIdentifier";
NSString* kDetailTextLabel = @"kDetailTextLabel";
NSString* kTextLabel = @"kTextLabel";
NSString* kDidSelectRow = @"kDidSelectRow";

@implementation ContentDetailViewController

@synthesize content;
@synthesize delegate;
@synthesize managedObjectContext;
@synthesize tableView;
@synthesize pastItem;
@synthesize pastStorage;
@synthesize pastQty;
@synthesize pastEntryDate;
@synthesize pastExpireDate;
@synthesize arrayDataSource;
@synthesize dateFormatter;

enum {
	FL_ENTRYDATE,
	FL_EXPIREDATE,
};

/*
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    // Configure the navigation bar
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter retain];
	
    self.navigationItem.title = NSLocalizedString(@"Content Detail", @"title");

	pastItem = content.item;
	pastStorage = content.storage;
	pastQty = [content.qty copy];
	pastEntryDate = [content.entryDate copy];
    pastExpireDate = [content.expireDate copy];
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.managedObjectContext = content.managedObjectContext;
	self.tableView.allowsSelectionDuringEditing = YES;
	[self addExtraButtons];

	self.arrayDataSource = [NSArray arrayWithObjects:
							[NSArray arrayWithObjects:
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Item", kCellIdentifier,
							  NSLocalizedString(@"Item", @"TextLabel"), kTextLabel,
							  @"showItemSelection", kDidSelectRow,
							  content.item.name, kDetailTextLabel,
							  nil],
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Storage", kCellIdentifier,
							  NSLocalizedString(@"Storage", @"TextLabel"), kTextLabel,
							  @"showStorageSelection", kDidSelectRow,
							  content.storage.name, kDetailTextLabel,
							  nil],
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"Quantity", kCellIdentifier,
							  NSLocalizedString(@"Quantity", @"TextLabel"), kTextLabel,
							  @"showQtyPicker", kDidSelectRow,
							  content.qty, kDetailTextLabel,
							  nil],
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"EntryDate", kCellIdentifier,
							  NSLocalizedString(@"Entry Date", @"TextLabel"), kTextLabel,
							  @"showEntryDatePicker", kDidSelectRow,
							  [dateFormatter stringFromDate:content.entryDate], kDetailTextLabel,
							  nil],
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"ExpireDate", kCellIdentifier,
							  NSLocalizedString(@"Expire Date", @"TextLabel"), kTextLabel,
							  @"showExpireDatePicker", kDidSelectRow,
							  [dateFormatter stringFromDate:content.expireDate], kDetailTextLabel,
							  nil],
							 nil],
							nil];
	[self setEditing:NO animated:NO];
}

- (void)addExtraButtons {
	CGRect rcFrame = {{0,0},{320,66}};
	NSArray* frames = [self arrayOfButtonFrame:rcFrame buttonSize:CGSizeMake(100, 44) numOfButton:2];
	UIView* v = [[UIView alloc] initWithFrame:rcFrame];
	UIButton* bUse = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
	UIButton* bDispose = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
	[v addSubview:bUse];
	[v addSubview:bDispose];
	bUse.frame = [[frames objectAtIndex:0] CGRectValue];
	bDispose.frame = [[frames objectAtIndex:1] CGRectValue];
	[bUse setTitle:NSLocalizedString(@"Consume All", @"Button") forState:UIControlStateNormal];
	[bDispose setTitle:NSLocalizedString(@"Dispose All", @"Button") forState:UIControlStateNormal];
	[bUse addTarget:self action:@selector(useThisContent) forControlEvents:UIControlEventTouchUpInside];
	[bDispose addTarget:self action:@selector(disposeThisContent) forControlEvents:UIControlEventTouchUpInside];
	self.tableView.tableFooterView = v;
	[v release];
	[frames release];
}

- (NSArray*)arrayOfButtonFrame:(CGRect)rectFrame buttonSize:(CGSize)size numOfButton:(NSInteger)num {
	NSMutableArray* a = [NSMutableArray arrayWithCapacity:num];
	for (int i = 0; i < num; i++) {
		[a addObject:[NSValue valueWithCGRect:CGRectMake ((rectFrame.size.width / num) * i + (rectFrame.size.width / num - size.width) / 2,
														  (rectFrame.size.height - size.height) / 2,
														  size.width, size.height)]];
	}
	return (NSArray*)[a retain];
}

- (void)useThisContent {
	NSManagedObject* history = [NSEntityDescription insertNewObjectForEntityForName:@"History"
															 inManagedObjectContext:content.managedObjectContext];
	[history setValue:[NSDate dateWithTimeIntervalSinceNow:0] forKey:@"date"];
	[history setValue:NSLocalizedString(@"Consume", @"HistoryVerb") forKey:@"verb"];
	[history setValue:NSLocalizedString(@"Content", @"HistoryObject") forKey:@"object"];
	[history setValue:content.item.name forKey:@"descr"];
	NSError* error;
	if (![history.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	[self.content.managedObjectContext deleteObject:self.content];
	self.content = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)disposeThisContent {
	NSManagedObject* history = [NSEntityDescription insertNewObjectForEntityForName:@"History"
															 inManagedObjectContext:content.managedObjectContext];
	[history setValue:[NSDate dateWithTimeIntervalSinceNow:0] forKey:@"date"];
	[history setValue:NSLocalizedString(@"Dispose", @"HistoryVerb") forKey:@"verb"];
	[history setValue:NSLocalizedString(@"Content", @"HistoryObject") forKey:@"object"];
	[history setValue:content.item.name forKey:@"descr"];
	NSError* error;
	if (![history.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	[self.content.managedObjectContext deleteObject:self.content];
	self.content = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidUnload {
	[super viewDidUnload];
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
	[self.delegate contentAddView:self didAddContent:content];
}


- (void)cancel {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.arrayDataSource count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSArray* array = [self.arrayDataSource objectAtIndex:section];
    return [array count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSArray* array = [self.arrayDataSource objectAtIndex:indexPath.section];
	NSDictionary* dict = [array objectAtIndex:indexPath.row];
    NSString *CellIdentifier = [dict valueForKey:kCellIdentifier];
	UITableViewCell *aCell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
	if (aCell == nil)
	{
		aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:CellIdentifier] autorelease];
	}
	aCell.selectionStyle = UITableViewCellSelectionStyleBlue;
	aCell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
	aCell.accessoryType = UITableViewCellAccessoryNone;
	aCell.textLabel.text = [dict valueForKey:kTextLabel];
	aCell.detailTextLabel.text = [dict valueForKey:kDetailTextLabel];
	return aCell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSArray* array = [self.arrayDataSource objectAtIndex:indexPath.section];
	NSDictionary* dict = [array objectAtIndex:indexPath.row];
	SEL sel = NSSelectorFromString([dict valueForKey:kDidSelectRow]);
	if (sel && self.editing) {
		[self performSelector:sel];
	}
}

- (void)showItemSelection {
	/*
	ItemSelectionViewController* isv = [ItemSelectionViewController alloc];
	[isv initWithNibName:@"ItemSelectionView" bundle:nil];
	 isv.managedObjectContext = self.managedObjectContext;
	isv.itemSelected = content.item;
	isv.delegate = self;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:isv];
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
	[isv release];
	 */
	ItemSelectionViewController* isv = [ItemSelectionViewController alloc];
	[isv initWithNibName:@"ItemSelectionView" bundle:nil];
	isv.managedObjectContext = self.managedObjectContext;
	isv.itemSelected = content.item;
	isv.delegate = self;
    [self.navigationController pushViewController:isv animated:YES];
	[isv release];
}

- (void)itemSelectionViewController:(ItemSelectionViewController*)itemSelectionViewController didSelectItem:(Item *)selectedItem {
    if (selectedItem) {
		NSArray* array = [self.arrayDataSource objectAtIndex:kSectionItem];
		NSDictionary* dict = [array objectAtIndex:kRowItem];
		[dict setValue:selectedItem.name forKey:kDetailTextLabel];
		content.item = selectedItem;
		UITableViewCell* tvcItem = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathItem length:2]];
		if (tvcItem) {
			tvcItem.detailTextLabel.text = selectedItem.name;
			[tvcItem setNeedsLayout];
		}
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)showStorageSelection {
	StorageSelectionViewController* ssv = [StorageSelectionViewController alloc];
	[ssv initWithNibName:@"StorageSelectionView" bundle:nil];
	ssv.managedObjectContext = self.managedObjectContext;
	ssv.storageSelected = content.storage;
	ssv.delegate = self;
    [self.navigationController pushViewController:ssv animated:YES];
	[ssv release];
}

- (void)storageSelectionViewController:(StorageSelectionViewController*)storageSelectionViewController
					  didSelectStorage:(Storage *)storage {
    if (storage) {        
		NSArray* array = [self.arrayDataSource objectAtIndex:kSectionStorage];
		NSDictionary* dict = [array objectAtIndex:kRowStorage];
		[dict setValue:storage.name forKey:kDetailTextLabel];
		UITableViewCell* tvcStorage = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathStorage length:2]];
        // Show the recipe in a new view controller
        // [self showRecipe:recipe animated:NO];
		if (content.storage.durationFactor != 0 &&
			content.storage.durationFactor != storage.durationFactor) {
			if (content.expireDate != nil) {
				// time to left
				NSTimeInterval ti = [content.expireDate timeIntervalSinceNow];
				// expand/shrink time according to storage factor
				ti = ti * [storage.durationFactor floatValue] / [content.storage.durationFactor floatValue];
				// calcurate new expireDate
				content.expireDate = [[NSDate dateWithTimeIntervalSinceNow:0] dateByAddingTimeInterval:ti];
				// change expireDate expression
				NSArray* arrayExpireDate = [self.arrayDataSource objectAtIndex:kSectionExpireDate];
				NSDictionary* dictExpireDate = [arrayExpireDate objectAtIndex:kRowExpireDate];
				[dictExpireDate setValue:storage.name forKey:kDetailTextLabel];
				UITableViewCell* tvcExpireDate = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathExpireDate length:2]];
				if (tvcExpireDate)
					tvcExpireDate.detailTextLabel.text = [self.dateFormatter stringFromDate:content.expireDate];
				[tvcExpireDate setNeedsLayout];
			}
		}
		content.storage = storage;
		if (tvcStorage)
			tvcStorage.detailTextLabel.text = storage.name;
		[tvcStorage setNeedsLayout];
    }
    
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)showQtyPicker {
	QtyPickerViewController* qpv = [QtyPickerViewController alloc];
	qpv.qty = content.qty;
	qpv.delegate = self;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:qpv];
    [self presentModalViewController:navigationController animated:YES];
	[qpv initWithNibName:@"QtyPickerView" bundle:nil];
    [navigationController release];
	[qpv release];
}

- (void)qtyPickerViewController:(QtyPickerViewController *)qtyPickerViewController
				  didPickerDone:(NSString *)qty {
	if (qty) {
		NSArray* array = [self.arrayDataSource objectAtIndex:kSectionQty];
		NSDictionary* dict = [array objectAtIndex:kRowQty];
		[dict setValue:qty forKey:kDetailTextLabel];
		UITableViewCell* tvcQty = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathQty length:2]];
		content.qty = qty;
		if (tvcQty)
			tvcQty.detailTextLabel.text = qty;
		[tvcQty setNeedsLayout];
	}
	[qtyPickerViewController dismissModalViewControllerAnimated:YES];
}

- (void)showEntryDatePicker {
	DatePickerViewController* dpv = [DatePickerViewController alloc];
	flagDate = FL_ENTRYDATE;
	dpv.date = content.entryDate;
	dpv.delegate = self;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dpv];
	[dpv initWithNibName:@"DatePickerView" bundle:nil];
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
	[dpv release];
}

- (void)showExpireDatePicker {
	DatePickerViewController* dpv = [DatePickerViewController alloc];
	dpv.date = content.expireDate;
	flagDate = FL_EXPIREDATE;
	dpv.delegate = self;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dpv];
	[dpv initWithNibName:@"DatePickerView" bundle:nil];
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
	[dpv release];
}

- (void)datePickerViewController:(DatePickerViewController *)datePickerViewController
				   didPickerDone:(NSDate *)date {
	if (date) {
		if (flagDate == FL_ENTRYDATE) {
			content.entryDate = date;
			NSString* str = [dateFormatter stringFromDate:content.entryDate];
			NSArray* array = [self.arrayDataSource objectAtIndex:kSectionEntryDate];
			NSDictionary* dict = [array objectAtIndex:kRowEntryDate];
			[dict setValue:str forKey:kDetailTextLabel];
			UITableViewCell* tvcEntryDate = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathEntryDate length:2]];
			if (tvcEntryDate)
				tvcEntryDate.detailTextLabel.text = str;
			[tvcEntryDate setNeedsLayout];
		} else if (flagDate == FL_EXPIREDATE) {
			content.expireDate = date;
			NSString* str = [dateFormatter stringFromDate:content.expireDate];
			NSArray* array = [self.arrayDataSource objectAtIndex:kSectionExpireDate];
			NSDictionary* dict = [array objectAtIndex:kRowExpireDate];
			[dict setValue:str forKey:kDetailTextLabel];
			UITableViewCell* tvcExpireDate = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathExpireDate length:2]];
			if (tvcExpireDate)
				tvcExpireDate.detailTextLabel.text = str;
			[tvcExpireDate setNeedsLayout];
		}
	}
	[datePickerViewController dismissModalViewControllerAnimated:YES];
}



- (void)dealloc {
	[dateFormatter release];
    [super dealloc];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
	[self.tableView setEditing:editing animated:animated];
	[self.navigationItem setHidesBackButton:editing animated:YES];

	if (editing) {
		pastItem = content.item;
		pastStorage = content.storage;
		pastQty = [content.qty copy];
		pastEntryDate = [content.entryDate copy];
		pastExpireDate = [content.expireDate copy];
	} else {
		NSManagedObjectContext *context = content.managedObjectContext;
		NSError *error = nil;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
		NSString* str = @"";
		if (pastItem != content.item) {
			str = [str stringByAppendingString:NSLocalizedString(@" Item", @"HistoryDescr")];
		}
		if (pastStorage != content.storage) {
			str = [str stringByAppendingString:NSLocalizedString(@" Storage", @"HistoryDescr")];
		}
		if ([pastQty compare:content.qty] != NSOrderedSame) {
			str = [str stringByAppendingString:NSLocalizedString(@" Qty", @"HistoryDescr")];
		}
		if ([pastEntryDate compare:content.entryDate] != NSOrderedSame) {
			str = [str stringByAppendingString:NSLocalizedString(@" EntryDate", @"HistoryDescr")];
		}
		if ([pastExpireDate compare:content.expireDate] != NSOrderedSame) {
			str = [str stringByAppendingString:NSLocalizedString(@" ExpireDate", @"HistoryDescr")];
		}
		if ([str length] != 0) {
			str = [content.item.name stringByAppendingString:str];
			NSManagedObject* history = [NSEntityDescription insertNewObjectForEntityForName:@"History"
																	 inManagedObjectContext:content.managedObjectContext];
			[history setValue:[NSDate dateWithTimeIntervalSinceNow:0] forKey:@"date"];
			[history setValue:NSLocalizedString(@"Modify", @"HistoryVerb") forKey:@"verb"];
			[history setValue:NSLocalizedString(@"Content", @"HistoryObject") forKey:@"object"];
			[history setValue:str forKey:@"descr"];
			if (![history.managedObjectContext save:&error]) {
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

@end
