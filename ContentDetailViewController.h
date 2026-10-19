//
//  ContentAddView.h
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemSelectionViewController.h"
#import "StorageSelectionViewController.h"
#import "QtyPickerViewController.h"
#import "DatePickerViewController.h"

@protocol ContentAddDelegate;

@class Content;

@interface ContentDetailViewController : UIViewController <ItemSelectDelegate,
	StorageSelectDelegate, QtyPickerDelegate, DatePickerDelegate,UINavigationControllerDelegate>{
@protected
	Content* content;
	id <ContentAddDelegate> delegate;
    NSManagedObjectContext *managedObjectContext;
	UITableView* tableView;
	NSInteger flagDate;
	id pastItem;
	id pastStorage;
	NSString* pastQty;
	NSDate* pastEntryDate;
	NSDate* pastExpireDate;
	NSArray* arrayDataSource;
	NSDateFormatter* dateFormatter;
		
}

@property(nonatomic, retain) Content *content;
@property(nonatomic, assign) id <ContentAddDelegate> delegate;
@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) id pastItem;
@property (nonatomic, retain) id pastStorage;
@property (nonatomic, retain) NSString* pastQty;
@property (nonatomic, retain) NSDate* pastEntryDate;
@property (nonatomic, retain) NSDate* pastExpireDate;
@property (nonatomic, retain) NSArray* arrayDataSource;
@property (nonatomic, retain) NSDateFormatter* dateFormatter;


- (void)save;
- (void)cancel;
- (void)showItemSelection;
- (void)showStorageSelection;
- (void)showQtyPicker;
- (void)showEntryDatePicker;
- (void)showExpireDatePicker;
- (void)addExtraButtons;
- (NSArray*)arrayOfButtonFrame:(CGRect)rectFrame buttonSize:(CGSize)size numOfButton:(NSInteger)num;
- (void)useThisContent;
- (void)disposeThisContent;

@end

@protocol ContentAddDelegate <NSObject>
- (void)contentAddView:(ContentDetailViewController *)contentAddView didAddContent:(Content *)content;
@end


extern const NSUInteger kSectionItem;
extern const NSUInteger kRowItem;
extern NSUInteger kPathItem[];
extern const NSUInteger kSectionStorage;
extern const NSUInteger kRowStorage;
extern NSUInteger kPathStorage[];
extern const NSUInteger kSectionQty;
extern const NSUInteger kRowQty;
extern NSUInteger kPathQty[];
extern const NSUInteger kSectionEntryDate;
extern const NSUInteger kRowEntryDate;
extern NSUInteger kPathEntryDate[];
extern const NSUInteger kSectionExpireDate;
extern const NSUInteger kRowExpireDate;
extern NSUInteger kPathExpireDate[];

extern NSString* kCellIdentifier;
extern NSString* kDetailTextLabel;

