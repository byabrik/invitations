//
//  SummaryViewController.m
//  Invitations
//
//  Created by admin on 11/12/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import "SummaryViewController.h"
#import "INVPerson.h"

@implementation SummaryViewController

-(void)viewDidLoad {
    
    [self reloadData];

    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void) reloadData {
    
    int receivedInvitations = 0;
    int personsApproved = 0;
    int personsDecliend = 0;
    int personsDidnAnswer = 0;
    int peopleNumber = 0;
    for (INVPerson * p in self.people) {
        if(p.ReceivedInvitation == YES)
        {
            receivedInvitations++;
        }
        if(p.InvitationState == PERSON_APPROVED)
        {
            personsApproved++;
            peopleNumber+= p.NumOfPeople;
        }
        if(p.InvitationState == PERSON_DECLINED)
        {
            personsDecliend++;
        }
        if(p.InvitationState == PERSON_NO_ANSWER_YET)
        {
            personsDidnAnswer++;
        }
        
    }
    
    self.receivedInvitationNumber.text = [NSString stringWithFormat:@"%d", receivedInvitations];
    self.approvedInvitationsNumber.text = [NSString stringWithFormat:@"%d", personsApproved];
    self.declinedInvitationsNumber.text = [NSString stringWithFormat:@"%d", personsDecliend];
    self.awatingResponseInvitationsNumber.text = [NSString stringWithFormat:@"%d", personsDidnAnswer];
    self.numberOfPeople.text = [NSString stringWithFormat:@"%d", peopleNumber];
    
}

@end
