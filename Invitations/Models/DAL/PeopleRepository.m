//
//  PeopleRepository.m
//  Invitations
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import "PeopleRepository.h"

@implementation PeopleRepository

- (NSMutableArray *) getAll {
    
    NSData* data = [self getData];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (BOOL) save: (NSMutableArray*) personList error:(NSError**)error {

    NSData* storedData = [NSKeyedArchiver archivedDataWithRootObject:personList];
    
    if(storedData != nil){
        return [self saveData:storedData error:error];
    }
    
    return false;
}

- (id)init {
    
    self = [super initWithFileName:@"people.dat"];
    if( !self ) return nil;
    
    return self;
}

-(NSString *)getFilePath {
    return dbFileName;
}

@end
