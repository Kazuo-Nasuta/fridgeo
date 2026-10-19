//
//  HistoryListTableViewController.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryCell;

@interface HistoryListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
	HistoryCell* historyCell;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, assign) IBOutlet HistoryCell* historyCell;

@end
