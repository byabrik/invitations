//
//  INVAppDelegate.h
//  Invitations
//
//  Created by admin on 10/31/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (INVAppDelegate*) sharedAppDelegate;
@property NSMutableArray *people;

@end
