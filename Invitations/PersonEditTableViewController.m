//
//  PersonEditTableViewController.m
//  Invitations
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import "PersonEditTableViewController.h"

@interface PersonEditTableViewController()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation PersonEditTableViewController

-(void)viewDidLoad {
    
    self.receivedInvitation.backgroundColor = [self ColorForReceivedInvitationView:self.person.ReceivedInvitation];
    self.invitationState.backgroundColor = [self ColorForInvitationStateView:self.person.InvitationState];
    self.numberOfPeople.text = [NSString stringWithFormat:@"%ld",(long)self.person.NumOfPeople];
    self.name.text = self.person.Name;
    
    //The setup code (in viewDidLoad in your view controller)
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    
    [self.view addGestureRecognizer:singleFingerTap];

    [super viewDidLoad];
    
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    UIView* view = recognizer.view;
    CGPoint loc = [recognizer locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    
    if(subview == self.receivedInvitation) {
        self.person.ReceivedInvitation = !self.person.ReceivedInvitation;
        
        self.receivedInvitation.backgroundColor = [self ColorForReceivedInvitationView:self.person.ReceivedInvitation];

    }
    
    if(subview == self.invitationState) {
        
        if(self.person.InvitationState == PERSON_APPROVED) {
            self.person.InvitationState = PERSON_DECLINED;
        }
        else if(self.person.InvitationState == PERSON_DECLINED) {
            self.person.InvitationState = PERSON_NO_ANSWER_YET;
        }
        else if(self.person.InvitationState == PERSON_NO_ANSWER_YET) {
            self.person.InvitationState = PERSON_APPROVED;
        }
        
        self.invitationState.backgroundColor = [self ColorForInvitationStateView:self.person.InvitationState];

    }
    
}

//- (UIColor *)toggleReceivedInvitation:(UIColor *)currentColor {
//    
//    if(currentColor == [UIColor greenColor])
//    
//}

- (UIColor *)ColorForReceivedInvitationView:(BOOL)receivedInvitation {
    
    if(receivedInvitation == YES) {
        return [UIColor greenColor];
    }
    else {
        return [UIColor grayColor];
    }
}

- (UIColor *)ColorForInvitationStateView:(NSInvitationState)invitationState {
    
    switch (invitationState) {
        case PERSON_APPROVED:
            return [UIColor greenColor];
            break;
        case PERSON_DECLINED:
            return [UIColor redColor];
            break;
        case PERSON_NO_ANSWER_YET:
            return [UIColor grayColor];
            break;
            
        default:
            return [UIColor grayColor];
            break;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    self.person.NumOfPeople = [self.numberOfPeople.text intValue];
    
}

-(NSInvitationState)getInvitationStateFromViewColor:(UIView *)view {
    
    UIColor *color = [view backgroundColor];
    if([color isEqual:[UIColor greenColor]]) {
        return PERSON_APPROVED;
    }
    
    if([color isEqual:[UIColor redColor]]) {
        return PERSON_DECLINED;
    }
    
    return PERSON_NO_ANSWER_YET;
}


-(NSInteger)getReceivedInvitationFromVIewColor:(UIView *)view {
    
    UIColor *color = [view backgroundColor];
    if([color isEqual:[UIColor greenColor]]) {
        return NO;
    }
    else {
        return YES;
    }
}


@end
