//
//  EntitySynchronizer.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/12/17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntitySynchronizer : NSObject {
	UIWindow* window;
	UIProgressView* pv;
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *frcStorage;
    NSFetchedResultsController *frcItem;
}
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *frcStorage;
@property (nonatomic, retain) NSFetchedResultsController *frcItem;

- (void)storageWrite;
- (void)storageRead;
- (void)itemWrite;
- (void)itemRead;

@end
