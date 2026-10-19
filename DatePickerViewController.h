//
//  DatePickerViewController.h
//  Fridgin
//
//  Created by 奈須田 一央 on 10/09/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate;

@interface DatePickerViewController : UIViewController {
	id <DatePickerDelegate> delegate;
	NSDate* date;
	UIDatePicker* pickerView;
}

@property (nonatomic, assign) id <DatePickerDelegate> delegate;
@property (nonatomic, retain) NSDate* date;
@property (nonatomic, retain) IBOutlet UIDatePicker* pickerView;

- (void)done;
- (void)cancel;

@end

@protocol DatePickerDelegate <NSObject>
- (void)datePickerViewController:(DatePickerViewController *)datePickerViewController
				   didPickerDone:(NSDate *)date;
@end
