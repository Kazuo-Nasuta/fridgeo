//
//  Image.h
//  Fridgeo
//
//  Created by 奈須田 一央 on 10/10/08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Item;
@class Storage;

@interface Image :  NSManagedObject  
{
}

@property (nonatomic, retain) id image;
@property (nonatomic, retain) Item * item;
@property (nonatomic, retain) Storage * storage;

@end



