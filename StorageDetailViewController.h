//
//  StorageAddView.h
//  FridgeNote
//
//  Created by 奈須田 一央 on 10/09/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StorageAddDelegate;
@class Storage;

@interface StorageDetailViewController : UIViewController
	<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
	@protected
	Storage* storage;
	UITextField* nameTextField;
	UITextField* durationFactorTextField;
	id <StorageAddDelegate> delegate;
	UIButton* photoButton;

}

@property (nonatomic, retain) Storage *storage;
@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet UITextField *durationFactorTextField;
@property (nonatomic, assign) id <StorageAddDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIButton* photoButton;

- (void)save;
- (void)cancel;
- (void)updatePhotoButton;
- (IBAction)photoTapped;

@end

@protocol StorageAddDelegate <NSObject>
// recipe == nil on cancel
- (void)storageAddView:(StorageDetailViewController *)storageAddView didAddStorage:(Storage *)storage;

@end
