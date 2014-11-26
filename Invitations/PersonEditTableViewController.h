//
//  PersonEditTableViewController.h
//  Invitations
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INVPerson.h"

@interface PersonEditTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIView *receivedInvitation;

@property (weak, nonatomic) IBOutlet UIView *invitationState;

@property (weak, nonatomic) IBOutlet UITextField *numberOfPeople;


@property INVPerson *person;

@end
