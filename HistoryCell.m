//
//  HistoryCell.m
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HistoryCell.h"


@implementation HistoryCell
@synthesize dateLabel;
@synthesize subjectLabel;
@synthesize verbLabel;
@synthesize objectLabel;
@synthesize descrLabel;

- (void)dealloc {
    [dateLabel release];
    [subjectLabel release];
    [verbLabel release];
    [objectLabel release];
    [descrLabel release];
    [super dealloc];
}


@end
