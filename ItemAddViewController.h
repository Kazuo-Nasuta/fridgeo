//
//  ItemAddViewController.h
//  Fridgin
//
//  Created by 奈須田 一央 on 10/10/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@protocol ItemAddDelegate;

@interface ItemAddViewController : ItemDetailViewController {
	id <ItemAddDelegate> delegate;
}
@property(nonatomic, assign) id <ItemAddDelegate> delegate;

- (void)save;
- (void)cancel;

@end

@protocol ItemAddDelegate <NSObject>
- (void)itemAddView:(ItemAddViewController *)itemAddView didAddItem:(Item *)item;
@end
