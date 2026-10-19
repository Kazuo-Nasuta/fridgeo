//
//  StorageAddView.m
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StorageDetailViewController.h"
#import "Storage.h"
#import	"Image.h"

@implementation StorageDetailViewController

@synthesize storage;
@synthesize nameTextField;
@synthesize durationFactorTextField;
@synthesize delegate;
@synthesize photoButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    // Configure the navigation bar
    self.navigationItem.title = NSLocalizedString(@"Storage Detail", @"NavTitle");
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	nameTextField.text = storage.name;
	durationFactorTextField.text = [storage.durationFactor stringValue];
	nameTextField.enabled = NO;
	durationFactorTextField.enabled = NO;
    [photoButton setImage:storage.thumbnailImage forState:UIControlStateNormal];
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
    
    [self dismissModalViewControllerAnimated:YES];
}


- (void)cancel {
    [self dismissModalViewControllerAnimated:YES];
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
	self.nameTextField = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
	[self.navigationItem setHidesBackButton:editing animated:YES];
	[self updatePhotoButton];
    
	nameTextField.enabled = editing;
	durationFactorTextField.enabled = editing;
	if (!editing) {
		storage.name = nameTextField.text;
		storage.durationFactor = [NSNumber numberWithFloat:[durationFactorTextField.text floatValue]];
		NSManagedObjectContext *context = storage.managedObjectContext;
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
	NSManagedObject *oldImage = storage.image;
	if (oldImage != nil) {
		[storage.managedObjectContext deleteObject:oldImage];
	}
	
    // Create an image object for the new image.
	NSManagedObject *image = [NSEntityDescription insertNewObjectForEntityForName:@"Image"
														   inManagedObjectContext:storage.managedObjectContext];
	storage.image = image;
	
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
	storage.thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[photoButton setImage:storage.thumbnailImage forState:UIControlStateNormal];
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
	
	if (storage.thumbnailImage != nil) {
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


@end
