//
//  DBTableLaunchView.h
//  DBTable
//
//  Created by 奈須田 一央 on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBTableLaunchViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	UIButton* btnLoad;
	UIButton* btnUpload;
	UIButton* btnEntity;
	UILabel* label;
	UITextField* tfFile;
	UINavigationController* navigationController;
	NSArray* arrayEntity;
	UIPickerView* pvEntity;
}

@property (nonatomic, retain) IBOutlet UIButton* btnLoad;
@property (nonatomic, retain) IBOutlet UIButton* btnUpload;
@property (nonatomic, retain) IBOutlet UIButton* btnEntity;
@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) IBOutlet UITextField* tfFile;
@property (nonatomic, retain) UINavigationController* navigationController;
@property (nonatomic, retain) NSArray* arrayEntity;
@property (nonatomic, retain) UIPickerView* pvEntity;

- (IBAction)pushLoad;
- (IBAction)pushUpload;
- (IBAction)pushEntity;
- (IBAction)cancel;

@end
