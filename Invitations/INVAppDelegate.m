//
//  INVAppDelegate.m
//  Invitations
//
//  Created by admin on 10/31/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import "INVAppDelegate.h"
#import "INVPerson.h"
#import "INVPeopleViewController.h"
#import "SummaryViewController.h"
#import "PeopleRepository.h"

@implementation INVAppDelegate
{
    NSDictionary *settings;
    BOOL willShowChooseContactsViewControllerOnStart;
    PeopleRepository* peopleRepository;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.people = [[NSMutableArray alloc] init];
    
    if(!willShowChooseContactsViewControllerOnStart) {
        
        self.people = [peopleRepository getAll];
        
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        UINavigationController *navigationController = [tabBarController viewControllers][0];
        INVPeopleViewController *peopleViewController = [navigationController viewControllers][0];
        peopleViewController.people = self.people;
        
        UINavigationController *navigationController2 = [tabBarController viewControllers][1];
        SummaryViewController *summaryViewController = [navigationController2 viewControllers][0];
        summaryViewController.people = self.people;
    }

    
    // Override point for customization after application launch.
    return YES;
}

- (NSString *) getRelativePath:(NSString *)directory filepath:(NSString *)filepath {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *URL = [documentsDirectory stringByAppendingPathComponent:directory];
    return [URL stringByAppendingPathComponent:filepath];
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    peopleRepository = [[PeopleRepository alloc] init];
    
    if([peopleRepository isEmpty])
    {
        willShowChooseContactsViewControllerOnStart = YES;
        UIStoryboard *storyboard = self.window.rootViewController.storyboard;
        UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SelectContactsNavigationController"];
        self.window.rootViewController = rootViewController;
        [self.window makeKeyAndVisible];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSError *saveError = [[NSError alloc] init];
    NSLog(@"Saving data to path: %@", [peopleRepository getFilePath]);
    if([peopleRepository save:self.people error:&saveError]) {
        NSLog(@"data seccessfuly saved");
    }
    else {
        NSLog(@"Failed to save data");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark access to app delegate etc.
+ (INVAppDelegate*) sharedAppDelegate {
    return (INVAppDelegate*)[[UIApplication sharedApplication] delegate];
}

@end
;