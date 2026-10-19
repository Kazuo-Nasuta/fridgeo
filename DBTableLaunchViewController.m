//
//  DBTableLaunchView.m
//  DBTable
//
//  Created by 奈須田 一央 on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DBTableLaunchViewController.h"
#import "DBTableViewController.h"

int DBCanceled = NO;

@interface  DBTableLaunchViewController () <DBSessionDelegate, DBTableViewDelegate, DBLoginControllerDelegate>
- (void)sessionAuthorize;
@end

@implementation DBTableLaunchViewController
@synthesize btnLoad;
@synthesize btnUpload;
@synthesize btnEntity;
@synthesize label;
@synthesize tfFile;
@synthesize navigationController;
@synthesize arrayEntity;
@synthesize pvEntity;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self sessionAuthorize];
	arrayEntity = [[NSArray arrayWithObjects:@"Item", @"Storage", nil] retain];
	[btnEntity setTitle:[arrayEntity objectAtIndex:0] forState:UIControlStateNormal];

	pvEntity = [UIPickerView alloc];
	pvEntity.delegate = self;
	pvEntity.dataSource = self;
	pvEntity.showsSelectionIndicator = YES;
	//CGRect rc = self.view.window.frame;
	//[pvEntity initWithFrame:CGRectMake(0, rc.size.height, rc.size.width, kPvEntityHeight)];
	[pvEntity initWithFrame:CGRectMake(0, 460, 0, 0)];
	[self.view addSubview:pvEntity];
	
}

-(void) viewDidAppear:(BOOL)animated {
	if (![[DBSession sharedSession] isLinked] && !DBCanceled) {
        DBLoginController* controller = [[DBLoginController new] autorelease];
		controller.delegate = self;
		[controller presentFromController:self];
		/*
		 } else {
		 [[DBSession sharedSession] unlink];
		 [[[[UIAlertView alloc] 
		 initWithTitle:@"Account Unlinked!" message:@"Your dropbox account has been unlinked" 
		 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
		 autorelease]
         show];
		 //        [self updateButtons];
		 */
    }
	DBCanceled = NO;
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

- (IBAction)pushLoad {
	
	
	DBTableViewController* dbtv = [DBTableViewController alloc];
	[dbtv initWithNibName:@"DBTableView" bundle:nil];
	dbtv.delegate = self;
	dbtv.dbTableViewType = kDBTableViewFileLoad;
//	dbtv.localFilename = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", tfFile.text];
	dbtv.localFilename = [[NSBundle mainBundle] pathForResource:btnEntity.titleLabel.text ofType:@"plist"];
    navigationController = [[UINavigationController alloc] initWithRootViewController:dbtv];
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
	navigationController = nil;
	[dbtv release];
}

- (IBAction)pushUpload {
	
	
	DBTableViewController* dbtv = [DBTableViewController alloc];
	[dbtv initWithNibName:@"DBTableView" bundle:nil];
	dbtv.delegate = self;
	dbtv.dbTableViewType = kDBTableViewFileUpload;
//	dbtv.localFilename = tfFile.text;
//	dbtv.localFilename = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", tfFile.text];
	dbtv.localFilename = [[NSBundle mainBundle] pathForResource:btnEntity.titleLabel.text ofType:@"plist"];
	
    navigationController = [[UINavigationController alloc] initWithRootViewController:dbtv];
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
	navigationController = nil;
	[dbtv release];
}

- (IBAction)pushEntity {
	[pvEntity selectRow:[arrayEntity indexOfObject:btnEntity.titleLabel.text] inComponent:0 animated:NO];
	CGRect rc = pvEntity.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	if (rc.origin.y >= 450) {
//		pvEntity.transform = CGAffineTransformMakeTranslation(0, -216); // Offset.
		pvEntity.transform = CGAffineTransformMakeTranslation(0, -309); // Offset.
	} else {
		pvEntity.transform = CGAffineTransformMakeTranslation(0, 0); // Offset.
	}
	[UIView commitAnimations];
}

- (IBAction)cancel {
}

#pragma mark DBLoginControllerDelegate methods

- (void)loginControllerDidLogin:(DBLoginController*)controller {
    //[self updateButtons];
    //[self.navigationController pushViewController:photoViewController animated:YES];
}

- (void)loginControllerDidCancel:(DBLoginController*)controller {
	DBCanceled = YES;
}

#pragma mark -
#pragma mark DBSessionDelegate methods

 - (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session {
	 //DBLoginController* loginController = [[DBLoginController new] autorelease];
	 //[loginController presentFromController:navigationController];
	 [self.navigationController popViewControllerAnimated:YES];
 }
 
#pragma mark -
#pragma mark Private methods
 
 - (void)sessionAuthorize {
	 NSString* consumerKey = @"udeoguoxhb1a1nt";
	 NSString* consumerSecret = @"hlbsurmhu2wt44n";
 
	 // Look below where the DBSession is created to understand how to use DBSession in your app
 
	 NSString* errorMsg = nil;
	 if ([consumerKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		 errorMsg = @"Make sure you set the consumer key correctly in DBRouletteAppDelegate.m";
	 } else if ([consumerSecret rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		 errorMsg = @"Make sure you set the consumer secret correctly in DBRouletteAppDelegate.m";
	 }
 
	 DBSession* session = 
	 [[DBSession alloc] initWithConsumerKey:consumerKey consumerSecret:consumerSecret];
	 session.delegate = self; // DBSessionDelegate methods allow you to handle re-authenticating
	 [DBSession setSharedSession:session];
	 [session release];
 
	 if (errorMsg != nil) {
		 [[[[UIAlertView alloc]
			initWithTitle:@"Error Configuring Session" message:errorMsg 
			delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
		   autorelease]
		  show];
	 }
}

#pragma mark -
#pragma mark DBTableViewDelegate methods

- (void)dbTableViewController:(DBTableViewController *)dbTableViewController didSelect:(NSString *)selected {
	//if (selected) {
	//	label.text = selected;
	//}
	
	[dbTableViewController dismissModalViewControllerAnimated:YES];

}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)mypickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSInteger index = [mypickerView selectedRowInComponent:0];
	NSString* str = [arrayEntity objectAtIndex:index];
	[btnEntity setTitle:str forState:UIControlStateNormal];
	[btnEntity setNeedsLayout];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	pvEntity.transform = CGAffineTransformMakeTranslation(0, 200); // Offset.
	[UIView commitAnimations];
	//[mypickerView removeFromSuperview];
}



#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [arrayEntity objectAtIndex:row];
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
	return [arrayEntity count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}



@end
