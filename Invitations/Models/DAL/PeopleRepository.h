//
//  PeopleRepository.h
//  Invitations
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRepository.h"
#import "INVPerson.h"

@interface PeopleRepository : AbstractRepository

- (NSMutableArray*) getAll;

- (BOOL) save: (NSMutableArray*) personList error:(NSError**)error;

- (id) init;

- (NSString*) getFilePath;

@end
