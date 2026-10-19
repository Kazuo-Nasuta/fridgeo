//
//  ItemListTableView.h
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/08/29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemAddViewController.h"

@interface ItemListTableViewController : UITableViewController <ItemAddDelegate, NSFetchedResultsControllerDelegate>{
@protected
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;

}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)showDetail:(NSIndexPath *)indexPath;

@end
