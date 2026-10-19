//
//  DatePickerViewController.m
//  Fridgin
//
//  Created by 奈須田 一央 on 10/09/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DatePickerViewController.h"


@implementation DatePickerViewController

@synthesize delegate, date, pickerView;

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
	self.navigationItem.title = NSLocalizedString(@"Date", @"NavTitle");
 
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
	
	if (date) {
		[pickerView setDate:date animated:NO];
	}
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

- (void)done {
	[self.delegate datePickerViewController:self didPickerDone:pickerView.date];
}

- (void)cancel {
	[self.delegate datePickerViewController:self didPickerDone:nil];
}


@end
