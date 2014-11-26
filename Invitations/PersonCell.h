//
//  PersonCell.h
//  Invitations
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *numOfPeopleLabel;
@property (nonatomic, weak) IBOutlet UIView *receivedInvitationsView;
@property (nonatomic, weak) IBOutlet UIView *invitationStateView;

@end
