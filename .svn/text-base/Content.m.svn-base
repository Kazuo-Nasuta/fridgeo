// 
//  Content.m
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Content.h"

#import "Item.h"
#import "Storage.h"

@implementation Content 

@dynamic expireStr;
@dynamic primitiveExpireStr;
@dynamic expireDate;
@dynamic primitiveExpireDate;
@dynamic entryStr;
@dynamic primitiveEntryStr;
@dynamic entryDate;
@dynamic primitiveEntryDate;
@dynamic qty;
@dynamic item;
@dynamic storage;

#pragma mark -
#pragma mark Transient properties

- (NSString *)entryStr {
    
    // Create and cache the section identifier on demand.
    
    [self willAccessValueForKey:@"entryStr"];
    NSString *tmp = [self primitiveEntryStr];
    [self didAccessValueForKey:@"entryStr"];
    
    if (!tmp) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		NSString* s = [dateFormatter stringFromDate:[self entryDate]];
		if (s == nil) {
			tmp = @"";
		} else {
			tmp = [NSString stringWithString:s];
		}
		[dateFormatter release];
        /*
         Sections are organized by month and year. Create the section identifier as a string representing the number (year * 1000) + month; this way they will be correctly ordered chronologically regardless of the actual name of the month.
         */
		/*
		 NSCalendar *calendar = [NSCalendar currentCalendar];
		 
		 NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[self timeStamp]];
		 tmp = [NSString stringWithFormat:@"%d", ([components year] * 1000) + [components month]];
		 [self setPrimitiveEntryStr:tmp];
		 */
        [self setPrimitiveEntryStr:tmp];
    }
    return tmp;
}

- (NSString *)expireStr {
    
    // Create and cache the section identifier on demand.
    
    [self willAccessValueForKey:@"expireStr"];
    NSString *tmp = [self primitiveExpireStr];
    [self didAccessValueForKey:@"expireStr"];
    
    if (!tmp) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		NSString* s = [dateFormatter stringFromDate:[self expireDate]];
		if (s == nil) {
			tmp = @"";
		} else {
			tmp = [NSString stringWithString:s];
		}
		[dateFormatter release];
        [self setPrimitiveExpireStr:tmp];
    }
    return tmp;
}


#pragma mark -
#pragma mark Time stamp setter

- (void)setEntryDate:(NSDate *)newDate {
    
    // If the time stamp changes, the section identifier become invalid.
    [self willChangeValueForKey:@"entryDate"];
    [self setPrimitiveEntryDate:newDate];
    [self didChangeValueForKey:@"entryDate"];
    
    [self setPrimitiveEntryStr:nil];
}

- (void)setExpireDate:(NSDate *)newDate {
    
    // If the time stamp changes, the section identifier become invalid.
    [self willChangeValueForKey:@"expireDate"];
    [self setPrimitiveExpireDate:newDate];
    [self didChangeValueForKey:@"expireDate"];
    
    [self setPrimitiveExpireStr:nil];
}


#pragma mark -
#pragma mark Key path dependencies

+ (NSSet *)keyPathsForValuesAffectingEntryStr {
    // If the value of timeStamp changes, the section identifier may change as well.
    return [NSSet setWithObject:@"entryDate"];
}

+ (NSSet *)keyPathsForValuesAffectingExpireStr {
    // If the value of timeStamp changes, the section identifier may change as well.
    return [NSSet setWithObject:@"expireDate"];
}




@end
