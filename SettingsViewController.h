//
//  SettingsViewController.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EntitySynchronizer;

@interface SettingsViewController : UITableViewController {
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    NSFetchedResultsController *controllerItem;
	UIButton* btnDropbox;
	UIButton* btnStorageWrite;
	UIButton* btnStorageRead;
	UIButton* btnItemWrite;
	UIButton* btnItemRead;
	NSArray* arrayDataSource;
	EntitySynchronizer* entitySynchronizer;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSFetchedResultsController *controllerItem;
@property (nonatomic, retain, readonly) UIButton *btnDropbox;
@property (nonatomic, retain, readonly) UIButton *btnStorageWrite;
@property (nonatomic, retain, readonly) UIButton *btnStorageRead;
@property (nonatomic, retain, readonly) UIButton *btnItemWrite;
@property (nonatomic, retain, readonly) UIButton *btnItemRead;
@property (nonatomic, retain) NSArray* arrayDataSource;
@property (nonatomic, retain) EntitySynchronizer* entitySynchronizer;

- (void)alertStorageWrite;
- (void)alertStorageRead;
- (void)alertItemWrite;
- (void)alertItemRead;
- (void)dropbox;
- (void)storageWrite;
- (void)storageRead;
- (void)itemWrite;
- (void)itemRead;
- (void)alertClearHistory;
- (void)clearHistory;
@end
