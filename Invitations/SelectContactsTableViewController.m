//
//  SelectContactsTableViewController.m
//  Invitations
//
//  Created by admin on 11/14/14.
//  Copyright (c) 2014 ___byabrik___. All rights reserved.
//

#import "SelectContactsTableViewController.h"
#import "ContactCell.h"
#import "INVPerson.h"
#import <AddressBook/AddressBook.h>
#import "Contact.h"
#import "INVPeopleViewController.h"
#import "SummaryViewController.h"
#import "INVAppDelegate.h"

@interface SelectContactsTableViewController ()

@end

@implementation SelectContactsTableViewController
{
    NSMutableArray *contactsList;
}

- (void)viewDidLoad {

    contactsList = [[NSMutableArray alloc] init];
    
    [self getAllContacts];
    
    [super viewDidLoad];
    
}

- (void)getAllContacts
{
    
    CFErrorRef *error = nil;
    
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL userDidGrantAddressBookAccess;
    CFErrorRef addressBookError = NULL;
    
    if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized )
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, &addressBookError);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
            userDidGrantAddressBookAccess = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
            ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted )
        {
            // Display an error.
        }
    }
    
    if (userDidGrantAddressBookAccess) {
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
        NSArray *allContacts = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        for(int i = 0; i < [allContacts count]; i++) {
            
            ABRecordRef person = (__bridge ABRecordRef)allContacts[i];
            
            NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
            
            Contact *c = [[Contact alloc] init];
            
            if(firstName.length) {
                c.Name = firstName;
            }
            
            if(lastName.length) {
                c.Name  = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            }
           
            ABMultiValueRef numbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            for (CFIndex j=0; j < ABMultiValueGetCount(numbers); j++) {
                
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(numbers, j);
                NSString *phoneNumber = (__bridge NSString *)phoneNumberRef;
                
                c.PhoneNumber = phoneNumber;
                
                INVPerson *p = [self isPersonInPeopleList:phoneNumber];
                
                if(p != nil) {
                    c.selected = YES;
                    c.personId = p.PersonId;
                } else {
                    c.personId = nil;
                }
                
                CFRelease(phoneNumberRef);
            }

            [contactsList addObject:c];
            
            CFRelease(numbers);
            CFRelease(person);
            
        }
        
        CFRelease(source);
    }
}
- (INVPerson*)isPersonInPeopleList:(NSString*)phoneNumber {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"PhoneNumber == %@", phoneNumber];
    
    NSArray *selectedContacts = [self.people filteredArrayUsingPredicate:predicate];
    
    if([selectedContacts count] > 0) {
        return selectedContacts[0];
    } else {
        return nil;
    }    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contactsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactCell *cell = (ContactCell*)[tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    Contact *contactAtIndex = [contactsList objectAtIndex:indexPath.row];
    
    cell.name.text = contactAtIndex.name;
    if(contactAtIndex.selected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Contact *c = [contactsList objectAtIndex:indexPath.row];
    c.selected = !c.selected;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
}

 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     UITabBarController *tabBarController = (UITabBarController *)[segue destinationViewController];
     UINavigationController *navigationController = [tabBarController viewControllers][0];
     INVPeopleViewController *peopleViewController = [navigationController viewControllers][0];

     
     UINavigationController *navigationController2 = [tabBarController viewControllers][1];
     SummaryViewController *summaryViewController = [navigationController2 viewControllers][0];
     
     NSMutableArray *peopleList = [self peopleFromContactList];
     
     INVAppDelegate *appDelegate = [INVAppDelegate sharedAppDelegate];
     
     appDelegate.people = peopleList;
     summaryViewController.people = peopleList;
     peopleViewController.people = peopleList;


 }

- (NSMutableArray*) peopleFromContactList {
    
    NSMutableArray* result = [[NSMutableArray alloc]init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"selected == %@", [NSNumber numberWithBool: YES]];
    
    NSArray *selectedContacts = [contactsList filteredArrayUsingPredicate:predicate];
    
    NSUInteger nContacts = [selectedContacts count];
    
    for(int i = 0; i < nContacts; i++) {
        
         Contact *contact = (Contact*)selectedContacts[i];
        
         if(contact.personId == nil) { //new contact selected, create new person fot it
             
             INVPerson *newPerson = [[INVPerson alloc]init];
             newPerson.Name = contact.name;
             newPerson.PhoneNumber = contact.phoneNumber;
             newPerson.PersonId = [[NSUUID UUID] UUIDString];
             newPerson.ReceivedInvitation = NO;
             newPerson.NumOfPeople = 0;
             newPerson.InvitationState = PERSON_NO_ANSWER_YET;
             
             [result addObject:newPerson];
             
         } else {
             
             //existing person, get it from people list
             NSPredicate *personWithPersonId = [NSPredicate predicateWithFormat:@"PersonId == %@", contact.personId];
             
             NSArray *peopleWithId = [self.people filteredArrayUsingPredicate:personWithPersonId];
             if(peopleWithId != nil) {
                 [result addObject:peopleWithId[0]];
             }
         }
    }
    
    return result;
}






@end
