//
//  FridgeoAppDelegate.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class ContentListTableViewController;
@class ItemListTableViewController;
@class StorageListTableViewController;
@class SettingsViewController;
@class HistoryListTableViewController;

@interface FridgeoAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow* window;
    UITabBarController* tabBarController;
    ContentListTableViewController* contentListTableViewController;
    ItemListTableViewController* itemListTableViewController;
    StorageListTableViewController* storageListTableViewController;
    SettingsViewController* settingsViewController;
	HistoryListTableViewController* historyListTableViewController;
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet ContentListTableViewController *contentListTableViewController;
@property (nonatomic, retain) IBOutlet ItemListTableViewController *itemListTableViewController;
@property (nonatomic, retain) IBOutlet StorageListTableViewController *storageListTableViewController;
@property (nonatomic, retain) IBOutlet SettingsViewController* settingsViewController;
@property (nonatomic, retain) IBOutlet HistoryListTableViewController* historyListTableViewController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

@end

