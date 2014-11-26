//
//  AbstractRepository.m
//  Invitations
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import "AbstractRepository.h"

@implementation AbstractRepository

- (BOOL)saveData:(NSData *)data error:(NSError**)error {
    
    return [data writeToFile:dbFileName options:NSDataWritingAtomic error:error];
}

- (NSData *)getData {
    
    return [NSData dataWithContentsOfFile:dbFileName];
}

-(id) initWithFileName: (NSString*)fileName {

    self = [super init];
    if( !self ) return nil;

    dbFileName = [self getFilePath:fileName];
    
    return self;
    
}

- (NSString *) getFilePath:(NSString*)fileName {
    
    NSURL* dataDirecotry = [self applicationDataDirectory];
    
    return [[dataDirecotry URLByAppendingPathComponent:fileName] path];
}

- (NSURL*)applicationDataDirectory {
    NSFileManager* sharedFM = [NSFileManager defaultManager];
    NSArray* possibleURLs = [sharedFM URLsForDirectory:NSApplicationSupportDirectory
                                             inDomains:NSUserDomainMask];
    NSURL* appSupportDir = nil;
    NSURL* appDirectory = nil;
    
    if ([possibleURLs count] >= 1) {
        // Use the first directory (if multiple are returned)
        appSupportDir = [possibleURLs objectAtIndex:0];
    }
    
    // If a valid app support directory exists, add the
    // app's bundle ID to it to specify the final directory.
    if (appSupportDir) {
        NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
        appDirectory = [appSupportDir URLByAppendingPathComponent:appBundleID];
    }
    
    //create directories if not exist
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError* error = [[NSError alloc]init];
    if (![fileManager fileExistsAtPath:[appDirectory path]]) {
        if(![fileManager createDirectoryAtPath:[appDirectory path] withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Unable to create directory on path: \r\n %@ \r\n %@", appDirectory, error);
        }
    }
    
    return appDirectory;
}

- (BOOL) isEmpty {
    
    return [self getData] == nil;
}


@end

































