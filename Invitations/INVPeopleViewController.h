//
//  INVPeopleViewController.h
//  Invitations
//
//  Created by admin on 10/31/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INVPerson.h"

@interface INVPeopleViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *people;

- (IBAction)unwindToPeopleList: (UIStoryboardSegue *)segue;

@end
