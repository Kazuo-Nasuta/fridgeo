//
//  ItemEditViewController.h
//  Fridgin
//
//  Created by 奈須田 一央 on 10/09/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QtyPickerViewController.h"
#import "SectionPickerViewController.h"
#import	"StorageSelectionViewController.h"

@class Item;

@interface ItemDetailViewController : UIViewController 
	<UINavigationControllerDelegate, UIImagePickerControllerDelegate,
	UITextFieldDelegate, QtyPickerDelegate, SectionPickerDelegate, StorageSelectDelegate, UITableViewDelegate> {
@protected
		Item* item;
		UITableView* tv;
		UIButton* photoButton;
		UITextField* nameTextField;
		UITextField* dayTextField;
		UITextField* monthTextField;
		UITextField* yearTextField;
		UITextField* tfToResign;
		NSArray* arrayDataSource;
}

@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) IBOutlet UITableView* tv;
@property (nonatomic, retain) IBOutlet UIButton* photoButton;
@property (nonatomic, retain) IBOutlet UITextField* nameTextField;
@property (nonatomic, retain, readonly) UITextField* dayTextField;
@property (nonatomic, retain, readonly) UITextField* monthTextField;
@property (nonatomic, retain, readonly) UITextField* yearTextField;
@property (nonatomic, retain) UITextField* tfToResign;
@property (nonatomic, retain) NSArray* arrayDataSource;

- (void)updatePhotoButton;
- (IBAction)photoTapped;
- (void)showQtyPicker;
- (void)showSectionPicker;
- (void)showStorageSelection;

@end

// section
extern const NSUInteger kSectionSection;
extern const NSUInteger kRowSection;
extern NSUInteger kPathSection[];
// quantity
extern const NSUInteger kItemSectionQty;
extern const NSUInteger kItemRowQty;
extern NSUInteger kItemPathQty[];
// storage
extern const NSUInteger kItemSectionStorage;
extern const NSUInteger kItemRowStorage;
extern NSUInteger kItemPathStorage[];
// default duration day
extern const NSUInteger kSectionDurationDay;
extern const NSUInteger kRowDurationDay;
extern NSUInteger kPathDurationDay[];
// default duration month
extern const NSUInteger kSectionDurationMonth;
extern const NSUInteger kRowDurationMonth;
extern NSUInteger kPathDurationMonth[];
// default duration year
extern const NSUInteger kSectionDurationYear;
extern const NSUInteger kRowDurationYear;
extern NSUInteger kPathDurationYear[];



