    //
//  StorageAddViewController.m
//  Fridgin
//
//  Created by 奈須田 一央 on 10/10/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StorageAddViewController.h"
#import "Storage.h"

@implementation StorageAddViewController

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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    // Configure the navigation bar
    self.navigationItem.title = NSLocalizedString(@"Add Storage", @"NavTitle");
    
    UIBarButtonItem *cancelButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"BarButton")
										 style:UIBarButtonItemStyleBordered
										target:self
										action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];
    
    UIBarButtonItem *saveButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Save", @"BarButton")
										 style:UIBarButtonItemStyleDone
										target:self
										action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    [saveButtonItem release];
	
	[nameTextField becomeFirstResponder];
	nameTextField.enabled = YES;
	durationFactorTextField.enabled = YES;
}

- (void)save {
    storage.name = nameTextField.text;
	storage.durationFactor = [NSNumber numberWithFloat:[durationFactorTextField.text floatValue]];
	
	NSError *error = nil;
	if (![storage.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	NSManagedObject* history = [NSEntityDescription insertNewObjectForEntityForName:@"History"
															 inManagedObjectContext:storage.managedObjectContext];
	[history setValue:[NSDate dateWithTimeIntervalSinceNow:0] forKey:@"date"];
	[history setValue:NSLocalizedString(@"Add", @"HistoryVerb") forKey:@"verb"];
	[history setValue:NSLocalizedString(@"Storage", @"HistoryObject") forKey:@"object"];
	[history setValue:storage.name forKey:@"descr"];
	if (![history.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	
	[self.delegate storageAddView:self didAddStorage:storage];
}


- (void)cancel {
	
	[storage.managedObjectContext deleteObject:storage];
	
	NSError *error = nil;
	if (![storage.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	
    [self.delegate storageAddView:self didAddStorage:nil];
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


@end
