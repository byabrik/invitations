//
//  INVPerson.h
//  Invitations
//
//  Created by admin on 10/31/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NSInvitationState) {
    PERSON_APPROVED,
    PERSON_DECLINED,
    PERSON_NO_ANSWER_YET
};

@interface INVPerson : NSObject <NSCoding>

@property NSString *PersonId;
@property NSString *Name;
@property BOOL ReceivedInvitation;
@property NSInvitationState InvitationState;
@property NSInteger NumOfPeople;
@property NSString* PhoneNumber;

@end
