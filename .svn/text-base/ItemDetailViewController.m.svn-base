//
//  ItemEditViewController.m
//  Fridgin
//
//  Created by 奈須田 一央 on 10/09/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Item.h"
#import "Storage.h"

static NSString* kSectionTitle = @"kSectionTitle";
static NSString* kCellIdentifier = @"kCellIdentifier";
static NSString* kTextLabel = @"kTextLabel";
static NSString* kDetailTextLabel = @"kDetailTextLabel";
static NSString* kSubView = @"kSubView";
static NSString* kEditingAccessoryType = @"kEditingAccessoryType";
static NSString* kDidSelectRow = @"kDidSelectRow";

// section
const NSUInteger kSectionSection = 0;
const NSUInteger kRowSection = 0;
NSUInteger kPathSection[] = {0, 0};
// quantity
const NSUInteger kItemSectionQty = 0;
const NSUInteger kItemRowQty = 1;
NSUInteger kItemPathQty[] = {0, 1};
// storage
const NSUInteger kItemSectionStorage = 0;
const NSUInteger kItemRowStorage = 2;
NSUInteger kItemPathStorage[] = {0, 2};
// default duration day
const NSUInteger kSectionDurationDay = 1;
const NSUInteger kRowDurationDay = 0;
NSUInteger kPathDurationDay[] = {1, 0};
// default duration month
const NSUInteger kSectionDurationMonth = 1;
const NSUInteger kRowDurationMonth = 1;
NSUInteger kPathDurationMonth[] = {1, 1};
// default duration year
const NSUInteger kSectionDurationYear = 1;
const NSUInteger kRowDurationYear = 2;
NSUInteger kPathDurationYear[] = {1, 2};




@implementation ItemDetailViewController

@synthesize item, tv, photoButton, nameTextField, dayTextField, monthTextField,
	yearTextField, tfToResign;
@synthesize arrayDataSource;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Item Detail";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

	self.arrayDataSource = [NSArray arrayWithObjects:
							[NSArray arrayWithObjects:
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"", kSectionTitle,
							  @"Section", kCellIdentifier,
							  NSLocalizedString(@"Section", @"TextLabel"), kTextLabel,
							  [NSNumber numberWithInt:UITableViewCellAccessoryDisclosureIndicator], kEditingAccessoryType,
							  @"showSectionPicker", kDidSelectRow,
							  item.section, kDetailTextLabel,
							  nil],
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"", kSectionTitle,
							  @"Default Quantity", kCellIdentifier,
							  NSLocalizedString(@"Default Quantity", @"TextLabel"), kTextLabel,
							  [NSNumber numberWithInt:UITableViewCellAccessoryDisclosureIndicator], kEditingAccessoryType,
							  @"showQtyPicker", kDidSelectRow,
							  item.defaultQty, kDetailTextLabel,
							  nil],
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"", kSectionTitle,
							  @"Default Storage", kCellIdentifier,
							  NSLocalizedString(@"Default Storage", @"TextLabel"), kTextLabel,
							  [NSNumber numberWithInt:UITableViewCellAccessoryDisclosureIndicator], kEditingAccessoryType,
							  @"showStorageSelection", kDidSelectRow,
							  item.defaultStorage.name, kDetailTextLabel,
							  nil],
							 nil],
							[NSArray arrayWithObjects:
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  NSLocalizedString(@"Default Duration", @"SectionTitle"), kSectionTitle,
							  @"Default Duration Day", kCellIdentifier,
							  NSLocalizedString(@"Day", @"TextLabel"), kTextLabel,
							  @"", kDetailTextLabel,
							  self.dayTextField, kSubView,
							  [NSNumber numberWithInt:UITableViewCellAccessoryNone], kEditingAccessoryType,
							  nil],
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  NSLocalizedString(@"Default Duration", @"SectionTitle"), kSectionTitle,
							  @"Default Duration Month", kCellIdentifier,
							  NSLocalizedString(@"Month", @"TextLabel"), kTextLabel,
							  @"", kDetailTextLabel,
							  self.monthTextField, kSubView,
							  [NSNumber numberWithInt:UITableViewCellAccessoryNone], kEditingAccessoryType,
							  nil],
							 [NSMutableDictionary dictionaryWithObjectsAndKeys:
							  NSLocalizedString(@"Default Duration", @"SectionTitle"), kSectionTitle,
							  @"Default Duration Year", kCellIdentifier,
							  NSLocalizedString(@"Year", @"TextLabel"), kTextLabel,
							  @"", kDetailTextLabel,
							  self.yearTextField, kSubView,
							  [NSNumber numberWithInt:UITableViewCellAccessoryNone], kEditingAccessoryType,
							  nil],
							 nil],
							nil];
	
	nameTextField.text = item.name;
	if (item.defaultDurationDay == nil) item.defaultDurationDay = [NSNumber numberWithInt:0];
	dayTextField.text = [item.defaultDurationDay stringValue];
	if (item.defaultDurationMonth == nil) item.defaultDurationMonth = [NSNumber numberWithInt:0];
	monthTextField.text = [item.defaultDurationMonth stringValue];
	if (item.defaultDurationYear == nil) item.defaultDurationYear = [NSNumber numberWithInt:0];
	yearTextField.text = [item.defaultDurationYear stringValue];
	nameTextField.enabled = NO;
	dayTextField.enabled = NO;
	monthTextField.enabled = NO;
	yearTextField.enabled = NO;
    [photoButton setImage:item.thumbnailImage forState:UIControlStateNormal];
	tv.allowsSelectionDuringEditing = YES;
}

- (void)cancel {
    [self dismissModalViewControllerAnimated:YES];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSArray* array = [self.arrayDataSource objectAtIndex:section];
	NSDictionary* dict = [array objectAtIndex:0];
	NSString* str = [dict valueForKey:kSectionTitle];
	
	return str;
}

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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.editingAccessoryType = [[dict valueForKey:kEditingAccessoryType] intValue];
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.textLabel.text = [dict valueForKey:kTextLabel];
	cell.detailTextLabel.text = [dict valueForKey:kDetailTextLabel];
	UIView* subview = [dict valueForKey:kSubView];
	if (subview) {
		[cell addSubview:subview];
	}
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray* array = [self.arrayDataSource objectAtIndex:indexPath.section];
	NSDictionary* dict = [array objectAtIndex:indexPath.row];
	SEL sel = NSSelectorFromString([dict valueForKey:kDidSelectRow]);
	if (sel && self.editing) {
		[self performSelector:sel];
	}
}

#pragma mark -
#pragma mark Editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
	[self.navigationItem setHidesBackButton:editing animated:YES];
    [self.tv setEditing:editing animated:animated];
	[self updatePhotoButton];
	nameTextField.enabled = editing;
	dayTextField.enabled = editing;
	monthTextField.enabled = editing;
	yearTextField.enabled = editing;
	if (!editing) {
		NSManagedObjectContext *context = item.managedObjectContext;
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


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

	if (textField == nameTextField) {
		item.name = nameTextField.text;
	}
	else if (textField == dayTextField) {
		item.defaultDurationDay = [NSNumber numberWithShort:[dayTextField.text integerValue]];
	}
	else if (textField == monthTextField) {
		item.defaultDurationMonth = [NSNumber numberWithShort:[monthTextField.text integerValue]];
	}
	else if (textField == yearTextField) {
		item.defaultDurationYear = [NSNumber numberWithShort:[yearTextField.text integerValue]];
	}
	
	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)tf {
	if (tf == nameTextField) {
		return;
	}
	NSInteger marginFromKeyboard = 10,keyboardHeight = 216;//interfaceOrientationによる
	NSInteger height = tv.frame.size.height;
	NSUInteger* path;
	if (tf == yearTextField) {
		path = kPathDurationYear;
	} else if (tf == monthTextField) {
		path = kPathDurationMonth;
	} else if (tf == dayTextField) {
		path = kPathDurationDay;
	}
	UITableViewCell* cell = [tv cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:path length:2]];
	if (cell) {
		CGRect tmpRect = cell.frame;
		if((tmpRect.origin.y + tmpRect.size.height + marginFromKeyboard + keyboardHeight) > height){
			NSInteger yOffset;
			yOffset = keyboardHeight + marginFromKeyboard + tmpRect.origin.y + tmpRect.size.height - height;
			[tv setContentOffset:CGPointMake(0,yOffset) animated:YES];
		}
	}
	
	UIButton* b = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
	[b setTitle:NSLocalizedString(@"Done", @"Button") forState:UIControlStateNormal];
	// create a UIButton (UIButtonTypeRoundedRect)
	b.frame = CGRectMake(0.0, 5.0, 60, 30);
	//roundedButtonType.backgroundColor = [UIColor clearColor]
	tfToResign = tf;
	[b addTarget:self action:@selector(resignKeyboard) forControlEvents:UIControlEventTouchUpInside];
	tf.rightView = b;
	tf.rightViewMode = UITextFieldViewModeAlways;
}

- (void)resignKeyboard {
	[tfToResign resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)tf {
	[tf.rightView release];
	tf.rightView = nil;
	[tv setContentOffset:CGPointMake(0,0) animated:YES];
}

#pragma mark -
#pragma mark Photo

- (IBAction)photoTapped {
    // If in editing state, then display an image picker; if not, create and push a photo view controller.
	if (self.editing) {
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		imagePicker.delegate = self;
		[self presentModalViewController:imagePicker animated:YES];
		[imagePicker release];
	} else {
		/*
		RecipePhotoViewController *recipePhotoViewController = [[RecipePhotoViewController alloc] init];
        recipePhotoViewController.hidesBottomBarWhenPushed = YES;
		recipePhotoViewController.recipe = recipe;
		[self.navigationController pushViewController:recipePhotoViewController animated:YES];
		[recipePhotoViewController release];
		 */
	}
}


- (void)imagePickerController:(UIImagePickerController *)picker
		didFinishPickingImage:(UIImage *)selectedImage
				  editingInfo:(NSDictionary *)editingInfo {
	// Delete any existing image.
	NSManagedObject *oldImage = item.image;
	if (oldImage != nil) {
		[item.managedObjectContext deleteObject:oldImage];
	}
	
    // Create an image object for the new image.
	NSManagedObject *image = [NSEntityDescription insertNewObjectForEntityForName:@"Image"
														   inManagedObjectContext:item.managedObjectContext];
	item.image = image;
	
	// Set the image for the image managed object.
	[image setValue:selectedImage forKey:@"image"];
	
	// Create a thumbnail version of the image for the recipe object.
	CGSize size = selectedImage.size;
	CGFloat ratio = 0;
	if (size.width > size.height) {
		ratio = 44.0 / size.width;
	} else {
		ratio = 44.0 / size.height;
	}
	CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
	UIGraphicsBeginImageContext(rect.size);
	[selectedImage drawInRect:rect];
	item.thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[photoButton setImage:item.thumbnailImage forState:UIControlStateNormal];
	photoButton.highlighted = self.editing;
    [self dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}


- (void)updatePhotoButton {
	/*
	 How to present the photo button depends on the editing state and whether the recipe has a thumbnail image.
	 * If the recipe has a thumbnail, set the button's highlighted state to the same as the editing state (it's highlighted if editing).
	 * If the recipe doesn't have a thumbnail, then: if editing, enable the button and show an image that says "Choose Photo" or similar; if not editing then disable the button and show nothing.  
	 */
	BOOL editing = self.editing;
	
	if (item.thumbnailImage != nil) {
		photoButton.highlighted = editing;
	} else {
		photoButton.enabled = editing;
		
		if (editing) {
			[photoButton setImage:[UIImage imageNamed:@"choosePhoto.png"] forState:UIControlStateNormal];
		} else {
			[photoButton setImage:nil forState:UIControlStateNormal];
		}
	}
}

#pragma mark -
#pragma mark QtyPickerViewController

- (void)showQtyPicker {
	QtyPickerViewController* qpv = [QtyPickerViewController alloc];
	qpv.qty = item.defaultQty;
	qpv.delegate = self;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:qpv];
	//UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    [self presentModalViewController:navigationController animated:YES];
	[qpv initWithNibName:@"QtyPickerView" bundle:nil];
    //[navigationController pushViewController:isv animated:YES];
    [navigationController release];
	[qpv release];
}

- (void)qtyPickerViewController:(QtyPickerViewController *)qtyPickerViewController
				  didPickerDone:(NSString *)qty {
	if (qty) {
		NSArray* array = [self.arrayDataSource objectAtIndex:kItemSectionQty];
		NSDictionary* dict = [array objectAtIndex:kItemRowQty];
		[dict setValue:qty forKey:kDetailTextLabel];
		item.defaultQty = qty;
		UITableViewCell* tvcQty = [tv cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kItemPathQty length:2]];
		if (tvcQty) {
			tvcQty.detailTextLabel.text = qty;
			[tvcQty setNeedsLayout];
		}
	}
	[qtyPickerViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark SectionPickerViewController

- (void)showSectionPicker {
	SectionPickerViewController* spv = [SectionPickerViewController alloc];
	spv.item = item;
	spv.delegate = self;
	[spv initWithNibName:@"SectionPickerView" bundle:nil];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:spv];
    [self presentModalViewController:navigationController animated:YES];	
    //[navigationController pushViewController:spv animated:YES];
    [navigationController release];
	[spv release];
}

- (void)sectionPickerViewController:(SectionPickerViewController *)sectionPickerViewController
				  didPickerDone:(Item *)myitem {
	if (myitem) {
		NSArray* array = [self.arrayDataSource objectAtIndex:kSectionSection];
		NSDictionary* dict = [array objectAtIndex:kRowSection];
		[dict setValue:myitem.section forKey:kDetailTextLabel];
		UITableViewCell* tvcSection = [tv cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kPathSection length:2]];
		if (tvcSection) {
			tvcSection.detailTextLabel.text = myitem.section;
			[tvcSection setNeedsLayout];
		}
	}
	[sectionPickerViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark StorageSelectDelegate

- (void)showStorageSelection {
	StorageSelectionViewController* ssv = [StorageSelectionViewController alloc];
	[ssv initWithNibName:@"StorageSelectionView" bundle:nil];
	ssv.managedObjectContext = item.managedObjectContext;
	ssv.storageSelected = item.defaultStorage;
	ssv.delegate = self;
    [self.navigationController pushViewController:ssv animated:YES];
	[ssv release];
}

- (void)storageSelectionViewController:(StorageSelectionViewController*)storageSelectionViewController didSelectStorage:(Storage *)storage {
    if (storage) {        
        // Show the recipe in a new view controller
        // [self showRecipe:recipe animated:NO];
		NSArray* array = [self.arrayDataSource objectAtIndex:kItemSectionStorage];
		NSDictionary* dict = [array objectAtIndex:kItemRowStorage];
		[dict setValue:storage.name forKey:kDetailTextLabel];
		item.defaultStorage = storage;
		UITableViewCell* tvcStorage = [tv cellForRowAtIndexPath:[NSIndexPath indexPathWithIndexes:kItemPathStorage length:2]];
		if (tvcStorage) {
			tvcStorage.detailTextLabel.text = storage.name;
			[tvcStorage setNeedsLayout];
		}
    }
    
    // Dismiss the modal add recipe view controller
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Text Field

- (UITextField *)yearTextField
{
	if (yearTextField == nil)
	{
		CGRect frame = CGRectMake(100, 8.0, 180, 30);
		yearTextField = [[UITextField alloc] initWithFrame:frame];
		yearTextField.borderStyle = UITextBorderStyleNone;
		yearTextField.textColor = [UIColor blackColor];
		yearTextField.font = [UIFont systemFontOfSize:17.0];
		//yearTextField.placeholder = @"<enter text>";
		yearTextField.backgroundColor = [UIColor whiteColor];
		yearTextField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		yearTextField.keyboardType = UIKeyboardTypeNumberPad;	// use the default type input method (entire keyboard)
		yearTextField.returnKeyType = UIReturnKeyDone;
		//yearTextField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		yearTextField.tag = 1;		// tag this control so we can remove it later for recycled cells
		yearTextField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
		// Add an accessibility label that describes what the text field is for.
		[yearTextField setAccessibilityLabel:NSLocalizedString(@"NormalTextField", @"")];
	}	
	return yearTextField;
}

- (UITextField *)monthTextField
{
	if (monthTextField == nil)
	{
		CGRect frame = CGRectMake(100, 8.0, 180, 30);
		monthTextField = [[UITextField alloc] initWithFrame:frame];
		monthTextField.borderStyle = UITextBorderStyleNone;
		monthTextField.textColor = [UIColor blackColor];
		monthTextField.font = [UIFont systemFontOfSize:17.0];
		//monthTextField.placeholder = @"<enter text>";
		monthTextField.backgroundColor = [UIColor whiteColor];
		monthTextField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		monthTextField.keyboardType = UIKeyboardTypeNumberPad;	// use the default type input method (entire keyboard)
		monthTextField.returnKeyType = UIReturnKeyDone;
		monthTextField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		monthTextField.tag = 1;		// tag this control so we can remove it later for recycled cells
		monthTextField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
		// Add an accessibility label that describes what the text field is for.
		[monthTextField setAccessibilityLabel:NSLocalizedString(@"NormalTextField", @"")];
	}	
	return monthTextField;
}

- (UITextField *)dayTextField
{
	if (dayTextField == nil)
	{
		CGRect frame = CGRectMake(100, 8.0, 180, 30);
		dayTextField = [[UITextField alloc] initWithFrame:frame];
		dayTextField.borderStyle = UITextBorderStyleNone;
		dayTextField.textColor = [UIColor blackColor];
		dayTextField.font = [UIFont systemFontOfSize:17.0];
		//dayTextField.placeholder = @"<enter text>";
		dayTextField.backgroundColor = [UIColor whiteColor];
		dayTextField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		dayTextField.keyboardType = UIKeyboardTypeNumberPad;	// use the default type input method (entire keyboard)
		dayTextField.returnKeyType = UIReturnKeyDone;
		dayTextField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		dayTextField.tag = 3;		// tag this control so we can remove it later for recycled cells
		dayTextField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
		// Add an accessibility label that describes what the text field is for.
		[dayTextField setAccessibilityLabel:NSLocalizedString(@"NormalTextField", @"")];
	}	
	return dayTextField;
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
    [super dealloc];
}

@end

