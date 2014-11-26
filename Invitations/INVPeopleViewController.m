//
//  INVPeopleViewController.m
//  Invitations
//
//  Created by admin on 10/31/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import "INVPeopleViewController.h"
#import "PersonCell.h"
#import "PersonEditTableViewController.h"
#import "SelectContactsTableViewController.h"

@interface INVPeopleViewController ()

@end

@implementation INVPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.people count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCell *cell = (PersonCell*)[tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
    
    INVPerson *person = [self.people objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = person.Name;
    cell.numOfPeopleLabel.text = [NSString stringWithFormat:@"%ld",(long)person.NumOfPeople];
    cell.receivedInvitationsView.alpha = 0.5;
    cell.receivedInvitationsView.layer.cornerRadius = 10;
    cell.receivedInvitationsView.backgroundColor = [self ColorForReceivedInvitationView:person.ReceivedInvitation];
   
    cell.invitationStateView.alpha = 0.5;
    cell.invitationStateView.layer.cornerRadius = 10;
    cell.invitationStateView.backgroundColor = [self ColorForInvitationStateView:person.InvitationState];
    
    return cell;
}

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"EditPerson"]) {
    
        CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
        
        INVPerson *person = [self.people objectAtIndex:hitIndex.row];
        UINavigationController *navController = [segue destinationViewController];
        PersonEditTableViewController *editController = [navController viewControllers][0];
        editController.person = person;
    }
    
    if([segue.identifier isEqualToString:@"ManageList"]) {
        
        UINavigationController *navigationController = [segue destinationViewController];
        SelectContactsTableViewController *s = [navigationController viewControllers][0];
        s.people = self.people;
    }
}

-(IBAction)unwindToPeopleList:(UIStoryboardSegue *)segue {
    
    PersonEditTableViewController *personEditController = [segue sourceViewController];
    INVPerson *person = personEditController.person;
    
    NSUInteger index = [self.people indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        
        INVPerson *item  = (INVPerson *)obj;

        if(item.PersonId == person.PersonId) {
            *stop = YES;
            return YES;
        }
        
        return NO;
    }];
    
    if (index != NSNotFound) {
        
        [_people replaceObjectAtIndex:index
                           withObject:person];
    }
    
    [self.tableView reloadData];
}






@end
