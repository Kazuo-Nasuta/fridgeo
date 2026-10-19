//
//  DBTableViewController.h
//  DBTable
//
//  Created by 奈須田 一央 on 10/11/22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropboxSDK.h"

@protocol DBTableViewDelegate;


@interface DBTableViewController : UITableViewController  <DBLoginControllerDelegate, DBRestClientDelegate, UITextFieldDelegate> {
	id <DBTableViewDelegate> delegate;
	DBRestClient* restClient;
	NSMutableArray* paths;
	NSString* curPath;
	UIActivityIndicatorView *indicator;
	UITextField* tfFilename;
	enum DBTableViewType {
		kDBTableViewFileLoad,
		kDBTableViewFileUpload,
	} dbTableViewType;
	NSString* localFilename;
	UIView*	vShade;
	UIProgressView* pv;
	UIView* vBase;
}
@property (nonatomic, assign) id <DBTableViewDelegate> delegate;
@property (nonatomic, readonly) DBRestClient* restClient;
@property (nonatomic, readonly) NSMutableArray* paths;
@property (nonatomic, copy) NSString* curPath;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;
@property (nonatomic, retain) UITextField* tfFilename;
@property (nonatomic, assign) enum DBTableViewType dbTableViewType;
@property (nonatomic, copy) NSString* localFilename;
@property (nonatomic, retain) UIView* vShade;
@property (nonatomic, retain) UIProgressView* pv;
@property (nonatomic, retain) IBOutlet UIView* vBase;
@end

@protocol DBTableViewDelegate <NSObject>
- (void)dbTableViewController:(DBTableViewController *)dbTableViewController didSelect:(NSString *)selected;
@end
