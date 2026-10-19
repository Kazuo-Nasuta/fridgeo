//
//  DataLoadController.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/11/03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Storage;

@interface DataLoadController : UIViewController {
	NSManagedObjectContext* context;
	UIProgressView* pv;
}
@property (nonatomic, retain) NSManagedObjectContext* context;
@property (nonatomic, retain) UIProgressView* pv;

- (void)storageRead:(NSManagedObjectContext*)moc;
- (void)itemRead:(NSManagedObjectContext*)moc;
- (Storage*)queryStorage:(NSString*)storagename managedObjectContext:(NSManagedObjectContext*)moc;
- (void) progress:(NSNumber *)amount;
- (void) progressWindow;

@end
