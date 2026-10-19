//
//  HistoryCell.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HistoryCell : UITableViewCell {
    UILabel *dateLabel;
    UILabel *subjectLabel;
    UILabel *verbLabel;
    UILabel *objectLabel;
    UILabel *descrLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *subjectLabel;
@property (nonatomic, retain) IBOutlet UILabel *verbLabel;
@property (nonatomic, retain) IBOutlet UILabel *objectLabel;
@property (nonatomic, retain) IBOutlet UILabel *descrLabel;

@end
