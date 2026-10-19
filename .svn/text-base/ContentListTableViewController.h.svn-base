//
//  ContentListTableView.h
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ContentDetailViewController.h"
#import "ContentAddViewController.h"

@class ContentTableViewCell;

@interface ContentListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate,ContentAddDelegate>{
@private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
	UISegmentedControl* seg;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UISegmentedControl* seg;

- (void)configureCell:(ContentTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)showDetail:(NSIndexPath *)indexPath;
- (void)segValueChanged;
	
@end
