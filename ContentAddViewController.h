//
//  ContentAddViewController.h
//  Fridgin
//
//  Created by 奈須田 一央 on 10/10/03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentDetailViewController.h"
@class Content;
@interface ContentAddViewController : ContentDetailViewController {
}

- (void)save;
- (void)cancel;

@end
