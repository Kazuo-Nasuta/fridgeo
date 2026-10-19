//
//  qtyPickViewController.h
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QtyPickerDelegate;

@interface QtyPickerViewController : UIViewController {
	id <QtyPickerDelegate> delegate;
	NSString* qty;
	UIPickerView* pickerView;
	NSArray* pickerArray0;
	NSArray* pickerArray1;
	NSArray* pickerArray2;
	NSArray* pickerArray3;
}

@property(nonatomic, assign) id <QtyPickerDelegate> delegate;
@property(nonatomic, retain) NSString* qty;
@property(nonatomic, retain) IBOutlet UIPickerView* pickerView;
@property(nonatomic, retain) NSArray* pickerArray1;
@property(nonatomic, retain) NSArray* pickerArray3;

- (void)initializePicker;
- (void)done;
- (void)cancel;

@end

@protocol QtyPickerDelegate <NSObject>
// recipe == nil on cancel
- (void)qtyPickerViewController:(QtyPickerViewController *)qtyPickerViewController
				  didPickerDone:(NSString *)qty;
@end

