//
//  DBTableViewController.m
//  DBTable
//
//  Created by 奈須田 一央 on 10/11/22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DBTableViewController.h"


@interface DBTableViewController ()
- (void)displayError;
- (void)load;
- (void)upload;
- (void)cancel;
- (void)showShade:(NSString*)caption;
@end

@implementation DBTableViewController
@synthesize delegate;
@synthesize paths;
@synthesize curPath;
@synthesize indicator;
@synthesize tfFilename;
@synthesize dbTableViewType;
@synthesize localFilename;
@synthesize vShade;
@synthesize pv;
@synthesize vBase;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization
	// that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	paths = nil;
    [super viewDidLoad];

	CGRect rc = self.view.bounds;
	indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, rc.size.width / 10.0, rc.size.width / 10.0)];
	[indicator setCenter:CGPointMake(rc.size.width / 2.0, rc.size.height / 3.0)];
	indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	[self.tableView addSubview: indicator];
	
	if (!curPath) {
		curPath = @"/";
		self.navigationItem.title = @"My Dropbox";
		UIBarButtonItem *cancelButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"BarButton")
										 style:UIBarButtonItemStyleBordered
										target:self
										action:@selector(cancel)];
		self.navigationItem.leftBarButtonItem = cancelButtonItem;
		[cancelButtonItem release];
	} else {
		self.navigationItem.title = [curPath lastPathComponent];
	}
	UIBarButtonItem *buttonItem;
	if (dbTableViewType == kDBTableViewFileLoad) {
		buttonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Load", @"BarButton")
													  style:UIBarButtonItemStyleBordered
													 target:self
													 action:@selector(load)];
	} else if (dbTableViewType == kDBTableViewFileUpload) {
		buttonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Upload", @"BarButton")
													  style:UIBarButtonItemStyleBordered
													 target:self
													 action:@selector(upload)];
	}
	self.navigationItem.rightBarButtonItem = buttonItem;
	[buttonItem release];
	
	if (dbTableViewType == kDBTableViewFileUpload) {
		CGFloat wMargin = 5.0;
		CGFloat wLabel = 80.0;
		CGFloat hLabel = 33.0;
		CGFloat hTextField = 24.0;
		UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rc.size.width, hLabel)];
		v.backgroundColor = [UIColor groupTableViewBackgroundColor];
		UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(wMargin, 0, wLabel, hLabel)];
		label.text = NSLocalizedString(@"Filename:", @"TextFieldLabel");
		label.font = [UIFont boldSystemFontOfSize:14];
		label.backgroundColor = [UIColor clearColor];
		[v addSubview:label];
		tfFilename = [[UITextField alloc] initWithFrame:CGRectMake(wMargin + wLabel,
																   (hLabel - hTextField) / 2,
																   rc.size.width - wLabel - (wMargin * 2),
																   hTextField)];
		tfFilename.borderStyle = UITextBorderStyleBezel;
		tfFilename.backgroundColor = [UIColor whiteColor];
		tfFilename.font = [UIFont systemFontOfSize:14];
		tfFilename.keyboardType = UIKeyboardTypeEmailAddress;
		tfFilename.delegate = self;
		tfFilename.text = [localFilename lastPathComponent];
		[v addSubview:tfFilename];
		self.tableView.tableHeaderView = v;
		[v release];
		[label release];
	}	
}

- (void)viewWillAppear:(BOOL)animated {
	//[[self restClient] loadMetadata:@"/"];
	[indicator startAnimating];
    [[self restClient] loadMetadata:curPath];
	[super viewWillAppear:animated];
}
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [paths count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	DBMetadata* metadata = [paths objectAtIndex:indexPath.row];
	cell.textLabel.text = [metadata.path substringFromIndex:[curPath length]];
	UIImage* img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:metadata.icon ofType:@"png"]];
	if (!img) {
		img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page_white" ofType:@"png"]];
	}
    cell.imageView.image = img;
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//
	// deselect when selected cell is tapped.
	//
	NSIndexPath* ip = indexPath;
	DBMetadata* metadata = [paths objectAtIndex:indexPath.row];
	NSIndexPath* ipSelected = [self.tableView indexPathForSelectedRow];
	if (!metadata.isDirectory && ipSelected && [indexPath compare:ipSelected] == NSOrderedSame) {
		[tableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
		ip = nil;
	}
	return ip;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	DBMetadata* metadata = [paths objectAtIndex:indexPath.row];
	if (metadata.isDirectory) {
		DBTableViewController* dtv = [DBTableViewController alloc];
		[dtv initWithNibName:@"DBTableView" bundle:nil];
		dtv.curPath = [metadata.path stringByAppendingString:@"/"];
		dtv.delegate = self.delegate;
		dtv.dbTableViewType = self.dbTableViewType;
		dtv.localFilename = self.localFilename;
		[self.navigationController pushViewController:dtv animated:YES];
		[dtv release];
	} else {
		tfFilename.text = [metadata.path lastPathComponent];
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
	[tfFilename release];
	[indicator release];
    [restClient release];
	[curPath release];
	[paths release];
    [super dealloc];
}

#pragma mark DBLoginControllerDelegate methods

- (void)loginControllerDidLogin:(DBLoginController*)controller {
    //[self updateButtons];
    //[self.navigationController pushViewController:photoViewController animated:YES];
}

- (void)loginControllerDidCancel:(DBLoginController*)controller {
	
}

#pragma mark DBRestClientDelegate methods

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
    
    //NSArray* validExtensions = [NSArray arrayWithObjects:@"jpg", @"jpeg", nil];
    //NSMutableArray* newPhotoPaths = [NSMutableArray new];
	if (paths) {
		[paths release];
		paths = nil;
	}
	paths = [[NSMutableArray new] init];
    for (DBMetadata* child in metadata.contents) {
		[paths addObject:child];
    }
	[self.tableView reloadData];
	[indicator stopAnimating];
}

- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path {
//    [self loadRandomPhoto];
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
	[indicator stopAnimating];
    //NSLog(@"restClient:loadMetadataFailedWithError: %@", [error localizedDescription]);
    [self displayError];
	//    [self setWorking:NO];
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath contentType:(NSString*)contentType {
	//NSLog(@"restClient:loadedFile destPath:%@ contentType:%@", destPath, contentType);
	[self.delegate dbTableViewController:self didSelect:destPath];
	[vShade removeFromSuperview];
	[vShade release];
	[self.navigationController setNavigationBarHidden:NO];
}

- (void)restClient:(DBRestClient*)client loadProgress:(CGFloat)progress forFile:(NSString*)destPath {
    //NSLog(@"restClient:loadProgress progress:%f destPath:%@", progress, destPath);
	pv.progress = progress;
}

- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error {
    [self displayError];
    [self.delegate dbTableViewController:self didSelect:nil];
	[vShade removeFromSuperview];
	[vShade release];
	[self.navigationController setNavigationBarHidden:NO];
}
// [error userInfo] contains the destinationPath

- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath {
}
- (void)restClient:(DBRestClient*)client loadThumbnailFailedWithError:(NSError*)error {
	[self displayError];
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath {
    //NSLog(@"restClient:uploadedFile destPath:%@ srcPath:%@", destPath, srcPath);
    [self.delegate dbTableViewController:self didSelect:destPath];
	[vShade removeFromSuperview];
	[vShade release];
	[self.navigationController setNavigationBarHidden:NO];
}

- (void)restClient:(DBRestClient*)client uploadProgress:(CGFloat)progress 
		   forFile:(NSString*)destPath from:(NSString*)srcPath {
    //NSLog(@"restClient:uploadProgress progress:%f destPath:%@ srcPath:%@", progress, destPath, srcPath);
	pv.progress = progress;
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
	[self displayError];
    [self.delegate dbTableViewController:self didSelect:nil];
	[vShade removeFromSuperview];
	[vShade release];
	[self.navigationController setNavigationBarHidden:NO];
}

#pragma mark private methods

- (void)displayError {
    [[[[UIAlertView alloc] 
       initWithTitle:@"Error Loading Photo" message:@"There was an error loading your photo." 
       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
      autorelease]
     show];
}

- (DBRestClient*)restClient {
    if (restClient == nil) {
    	restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    	restClient.delegate = self;
    }
    return restClient;
}

- (void)load {
	NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
	if (indexPath) {
		DBMetadata* metadata = [paths objectAtIndex:indexPath.row];
		[self showShade:NSLocalizedString(@"Loading...", @"LoadingMsg")];
		[[self restClient] loadFile:metadata.path intoPath:localFilename];
	}
}

- (void)upload {
	NSString* destFilename;
	NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
	if (indexPath) {
		DBMetadata* metadata = [paths objectAtIndex:indexPath.row];
		destFilename = [metadata.path lastPathComponent];
	} else {
		destFilename = [localFilename lastPathComponent];
	}
	
	[self showShade:NSLocalizedString(@"Uploading...", @"LoadingMsg")];
	
	[[self restClient] uploadFile:destFilename
						   toPath:curPath
						 fromPath:localFilename];
	
}

- (void)showShade:(NSString*)caption {
	[self.navigationController setNavigationBarHidden:YES animated:YES];

	vShade = [[UIView alloc] initWithFrame:[self.view.window bounds]];
	vShade.backgroundColor = [UIColor blackColor];
	vShade.alpha = 0.7;
	
	CGRect rc = {{vShade.bounds.origin.x + 10, vShade.center.y}, {vShade.bounds.size.width - 20, 40}};
	pv = [[UIProgressView alloc] initWithFrame:rc];
	pv.progressViewStyle= UIProgressViewStyleDefault;
	[vShade addSubview:pv];
	pv.progress = 0;
	
	CGRect rcLabel = {{vShade.bounds.origin.x + 10, vShade.center.y - 40}, {vShade.bounds.size.width - 20, 40}};
	UILabel* label = [[UILabel alloc] initWithFrame:rcLabel];
	label.text = caption;
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor grayColor];
	label.font = [UIFont boldSystemFontOfSize:16];
	label.textAlignment = UITextAlignmentCenter;
	label.backgroundColor = [UIColor clearColor];
	[vShade addSubview:label];
	[self.view.window addSubview:vShade];
	
}

- (void)cancel {
    [self.delegate dbTableViewController:self didSelect:nil];
}

#pragma mark textField methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

@end

