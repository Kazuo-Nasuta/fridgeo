//
//  SectionPickerViewController.h
//  Fridgin
//
//  Created by 奈須田 一央 on 10/10/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@protocol SectionPickerDelegate;

@interface SectionPickerViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate> {
	id <SectionPickerDelegate> delegate;
	Item* item;
	UITextField* sectionTextField;
	UIPickerView* pickerView;
	NSMutableArray* pickerArray;
}

@property(nonatomic, assign) id <SectionPickerDelegate> delegate;
@property(nonatomic, retain) Item* item;
@property(nonatomic, retain) IBOutlet UITextField* sectionTextField;
@property(nonatomic, retain) IBOutlet UIPickerView* pickerView;
@property(nonatomic, retain) NSMutableArray* pickerArray;

- (void)initializePicker;
- (void)done;
- (void)cancel;
@end

@protocol SectionPickerDelegate <NSObject>
- (void)sectionPickerViewController:(SectionPickerViewController *)sectionPickerViewController
					  didPickerDone:(Item*)item;
@end
