//
//  SummaryViewController.h
//  Invitations
//
//  Created by admin on 11/12/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *receivedInvitationNumber;
@property (weak, nonatomic) IBOutlet UILabel *approvedInvitationsNumber;
@property (weak, nonatomic) IBOutlet UILabel *declinedInvitationsNumber;
@property (weak, nonatomic) IBOutlet UILabel *awatingResponseInvitationsNumber;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeople;

@property (nonatomic, strong) NSMutableArray *people;

@end
