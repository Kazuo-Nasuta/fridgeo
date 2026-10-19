// 
//  Item.m
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Item.h"

#import "Content.h"
#import "Storage.h"

@implementation Item 

@dynamic thumbnailImage;
@dynamic section;
@dynamic defaultDurationYear;
@dynamic defaultQty;
@dynamic defaultDurationMonth;
@dynamic name;
@dynamic defaultDurationDay;
@dynamic content;
@dynamic defaultStorage;
@dynamic image;

@end

@implementation ImageToDataTransformer


+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [NSData class];
}


- (id)transformedValue:(id)value {
	NSData *data = UIImagePNGRepresentation(value);
	return data;
}


- (id)reverseTransformedValue:(id)value {
	UIImage *uiImage = [[UIImage alloc] initWithData:value];
	return [uiImage autorelease];
}

@end