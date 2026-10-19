//
//  Storage.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Content;
@class Image;
@class Item;

@interface Storage :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * durationFactor;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSSet* item;
@property (nonatomic, retain) NSSet* content;
@property (nonatomic, retain) NSManagedObject * image;

@end


@interface Storage (CoreDataGeneratedAccessors)
- (void)addItemObject:(Item *)value;
- (void)removeItemObject:(Item *)value;
- (void)addItem:(NSSet *)value;
- (void)removeItem:(NSSet *)value;

- (void)addContentObject:(Content *)value;
- (void)removeContentObject:(Content *)value;
- (void)addContent:(NSSet *)value;
- (void)removeContent:(NSSet *)value;

@end

