//
//  ItemSelectionViewController.h
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemListTableViewController.h"
@class Item;
@protocol ItemSelectDelegate;

@interface ItemSelectionViewController : ItemListTableViewController <NSFetchedResultsControllerDelegate>{
	id <ItemSelectDelegate> delegate;
	Item* itemSelected;
}

@property(nonatomic, assign) id <ItemSelectDelegate> delegate;
@property(nonatomic, retain) Item* itemSelected;

- (void)cancel;

@end



@protocol ItemSelectDelegate <NSObject>
// recipe == nil on cancel
- (void)itemSelectionViewController:(ItemSelectionViewController *)itemSelectionViewController didSelectItem:(Item *)item;

@end
