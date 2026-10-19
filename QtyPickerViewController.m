//
//  qtyPickViewController.m
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QtyPickerViewController.h"


@implementation QtyPickerViewController
@synthesize delegate, qty, pickerView, pickerArray1, pickerArray3;


- (void)done {
	[self.delegate qtyPickerViewController:self didPickerDone:qty];
}


- (void)cancel {
	[self.delegate qtyPickerViewController:self didPickerDone:nil];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Quantity", @"NavTitle");
    
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
	
	pickerArray0 = [[NSArray arrayWithObjects:
					@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",
					nil] retain];
	pickerArray1 = [[NSArray arrayWithObjects:
					@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @",", @"/",
					nil] retain];
	pickerArray2 = [[NSArray arrayWithObjects:
					@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",
					nil] retain];
	pickerArray3 = [[NSArray arrayWithObjects:
					@"pcs.", @"oz.", @"lb.", @"pt.", @"qt.", @"gal.", @"g", @"kg", @"cc", @"l", @"個", @"尾",
					nil] retain];
	
	[self initializePicker];
}

-(void) initializePicker {
	if ([qty compare:@""] == NSOrderedSame) {
		qty = @"1pcs.";
	}
	// make 3digits "000"
	[pickerView selectRow:[pickerArray1 indexOfObject:@"0"] inComponent:0 animated:NO];
	[pickerView selectRow:[pickerArray1 indexOfObject:@"0"] inComponent:1 animated:NO];
	[pickerView selectRow:[pickerArray1 indexOfObject:@"0"] inComponent:2 animated:NO];
	// find the start location of string represents unit. result will be in aRange.location
	NSCharacterSet* aSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789,./"] invertedSet];
	NSRange aRange = [qty rangeOfCharacterFromSet:aSet];
	// spin wheels from the nearest by unit wheel.
	int row;
	int index = aRange.location - 1;
	row = [pickerArray2 indexOfObject:[NSString stringWithFormat:@"%c", [qty characterAtIndex:index]]];
	[pickerView selectRow:row inComponent:2 animated:NO];
	if (-- index >= 0) {
		row = [pickerArray1 indexOfObject:[NSString stringWithFormat:@"%c", [qty characterAtIndex:index]]];
		[pickerView selectRow:row inComponent:1 animated:NO];
		if (-- index >= 0) {
			row = [pickerArray0 indexOfObject:[NSString stringWithFormat:@"%c", [qty characterAtIndex:index]]];
			[pickerView selectRow:row inComponent:0 animated:NO];
		}
	}
	// spin the wheel of unit.
	row = [pickerArray3 indexOfObject:[qty substringFromIndex:aRange.location]];
	[pickerView selectRow:row inComponent:3 animated:NO];
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
    [super dealloc];
}


#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)myPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	// woule like to change "001" into "1" but not to change "0.1" as the same.
	NSString* str0 = [pickerArray1 objectAtIndex:[myPickerView selectedRowInComponent:0]];
	NSString* str1 = [pickerArray1 objectAtIndex:[myPickerView selectedRowInComponent:1]];
	NSString* str2 = [pickerArray1 objectAtIndex:[myPickerView selectedRowInComponent:2]];
	if ([str1 compare:@"."] != NSOrderedSame &&
		[str1 compare:@","] != NSOrderedSame &&
		[str1 compare:@"/"] != NSOrderedSame) {
		if ([str0 compare:@"0"] == NSOrderedSame) {
			str0 = @"";
			if ([str1 compare:@"0"] == NSOrderedSame) {
				str1 = @"";
			}
		}
	}
	self.qty = [NSString stringWithFormat:@"%@%@%@%@", str0, str1, str2,
				[pickerArray3 objectAtIndex:[pickerView selectedRowInComponent:3]]];
}



#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	
	if (component == 1)
	{
		returnStr = [pickerArray1 objectAtIndex:row];
	}
	else if (component == 3)
	{
		returnStr = [pickerArray3 objectAtIndex:row];
	}
	else
	{
		returnStr = [[NSNumber numberWithInt:row] stringValue];
	}
	
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
	
	if (component == 3)
		componentWidth = 160.0;	// first column size is wider to hold names
	else
		componentWidth = 40.0;	// second column is narrower to show numbers
	
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	NSInteger num = 10;
	if (component == 1) {
		num = [pickerArray1 count];
	}
	else if (component == 3) {
		num = [pickerArray3 count];
	}
	return num;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 4;
}


@end
