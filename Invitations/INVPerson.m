//
//  INVPerson.m
//  Invitations
//
//  Created by admin on 10/31/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import "INVPerson.h"

@implementation INVPerson
@synthesize PersonId, Name, ReceivedInvitation, InvitationState, NumOfPeople,PhoneNumber;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    // add [super encodeWithCoder:encoder] if the superclass implements NSCoding
    [encoder encodeObject:PersonId forKey:@"PersonId"];
    [encoder encodeObject:Name forKey:@"Name"];
    [encoder encodeBool:ReceivedInvitation forKey:@"ReceivedInvitation"];
    [encoder encodeInteger:InvitationState forKey:@"InvitationState"];
    [encoder encodeInteger:NumOfPeople forKey:@"NumOfPeople"];
    [encoder encodeObject:PhoneNumber forKey:@"PhoneNumber"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        PersonId = [aDecoder decodeObjectForKey:@"PersonId"];
        Name = [aDecoder decodeObjectForKey:@"Name"];
        ReceivedInvitation = [aDecoder decodeBoolForKey:@"ReceivedInvitation"];
        InvitationState = [aDecoder decodeIntegerForKey:@"InvitationState"];
        NumOfPeople = [aDecoder decodeIntegerForKey:@"NumOfPeople"];
        PhoneNumber = [aDecoder decodeObjectForKey:@"PhoneNumber"];
    }
    return self;
}

@end
