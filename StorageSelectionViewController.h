//
//  StorageSelectionViewController.h
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StorageListTableViewController.h"
@class Storage;
@protocol StorageSelectDelegate;

@interface StorageSelectionViewController : StorageListTableViewController {
	id <StorageSelectDelegate> delegate;
	Storage* storageSelected;
}

@property(nonatomic, assign) id <StorageSelectDelegate> delegate;
@property(nonatomic, retain) Storage* storageSelected;

@end



@protocol StorageSelectDelegate <NSObject>
// recipe == nil on cancel
- (void)storageSelectionViewController:(StorageSelectionViewController *)storageSelectionViewController didSelectStorage:(Storage *)storage;

@end
