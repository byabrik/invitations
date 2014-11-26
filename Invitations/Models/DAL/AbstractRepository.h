//
//  AbstractRepository.h
//  Invitations
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractRepository : NSObject {
    NSString* dbFileName;
}

-(id) initWithFileName: (NSString*)fileName;

-(BOOL) saveData: (NSData *)data error:(NSError**)error;

-(NSData *) getData;

- (BOOL) isEmpty;

@end
