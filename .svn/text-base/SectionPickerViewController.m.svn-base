//
//  SectionPickerViewController.m
//  Fridgin
//
//  Created by 奈須田 一央 on 10/10/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SectionPickerViewController.h"
#import "Item.h"

@implementation SectionPickerViewController
@synthesize delegate, item, sectionTextField, pickerView, pickerArray;

- (void)done {
	item.section = sectionTextField.text;
	NSManagedObjectContext* context = item.managedObjectContext;
	NSError* error;
	[context save:&error];
	[delegate sectionPickerViewController:self didPickerDone:item];
}


- (void)cancel {
	[delegate sectionPickerViewController:self didPickerDone:nil];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = NSLocalizedString(@"Section", @"NavTitle");
 
	UIBarButtonItem *cancelButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"BarButton")
										 style:UIBarButtonItemStyleBordered
										target:self
										action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButtonItem;
	[cancelButtonItem release];
 
	UIBarButtonItem *doneButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"BarButton")
										style:UIBarButtonItemStyleDone
										target:self
										action:@selector(done)];
	self.navigationItem.rightBarButtonItem = doneButtonItem;
	[doneButtonItem release];

	[self initializePicker];
	sectionTextField.text = item.section;
}
 
-(void) initializePicker {
	NSManagedObjectContext *context = item.managedObjectContext;
	NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Item" inManagedObjectContext:context];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	[request setResultType:NSDictionaryResultType];
	[request setReturnsDistinctResults:YES];
	[request setPropertiesToFetch :[NSArray arrayWithObject:@"section"]];
	
	// Execute the fetch.
	NSError *error;
	//id requestedValue = nil;
	NSArray* array = [context executeFetchRequest:request error:&error];
	NSEnumerator *enumerator = [array objectEnumerator];
	pickerArray = [NSMutableArray arrayWithCapacity:[array count]];
	[pickerArray retain];
	BOOL exist = NO;
	id anObject;
	while (anObject = [enumerator nextObject]) {
		NSString* str = [anObject valueForKey:@"section"];
		[pickerArray addObject:str];
		if ([str compare:NSLocalizedString(@"none", @"SectionPicker")] == NSOrderedSame) {
			exist = YES;
		}
	}
	if (!exist) {
		[pickerArray addObject:NSLocalizedString(@"none", @"SectionPicker")];
	}

	
	int row = 0;
	NSString* s = item.section;
	if (s != nil) {
		row = [self.pickerArray indexOfObject:s];
	}
	[pickerView selectRow:row inComponent:0 animated:NO];
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
	[pickerArray release];
	pickerArray = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)mypickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSInteger index = [mypickerView selectedRowInComponent:0];
	NSString* str = [pickerArray objectAtIndex:index];
	sectionTextField.text = str;
}



#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [pickerArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return 280;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [pickerArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}


#pragma mark -
#pragma mark UITextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}


@end
