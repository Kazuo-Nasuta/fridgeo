//
//  StrageListTableView.h
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/08/29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "StorageDetailViewController.h"
#import "StorageAddViewController.h"

@interface StorageListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate,StorageAddDelegate> {
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)showDetail:(NSIndexPath *)indexPath;

@end
