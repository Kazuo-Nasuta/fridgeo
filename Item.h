//
//  Item.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Content;
@class Storage;

@interface ImageToDataTransformer : NSValueTransformer {
}
@end

@interface Item :  NSManagedObject  
{
}

@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSNumber * defaultDurationYear;
@property (nonatomic, retain) NSString * defaultQty;
@property (nonatomic, retain) NSNumber * defaultDurationMonth;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * defaultDurationDay;
@property (nonatomic, retain) NSSet* content;
@property (nonatomic, retain) Storage * defaultStorage;
@property (nonatomic, retain) NSManagedObject * image;

@end


@interface Item (CoreDataGeneratedAccessors)
- (void)addContentObject:(Content *)value;
- (void)removeContentObject:(Content *)value;
- (void)addContent:(NSSet *)value;
- (void)removeContent:(NSSet *)value;

@end

