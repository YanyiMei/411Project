//
//  SecondViewController.m
//  411Project
//
//  Created by Yanyi Mei on 11/4/13.
//  Copyright (c) 2013 Yanyi Mei. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *contacts;
    NSArray *cSections;
    __weak IBOutlet UITableView *contactTable;
}
@end

@implementation SecondViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    contacts = @[@[@"Blaze"], @[@"Creeper"], @[@"Ender"], @[@"Ghast"], @[@"Steve", @"Skeleton", @"Slime"], @[@"Wither Skeleton"], @[@"Zombie", @"Zombie Pigman"]];
    cSections = @[@"B", @"C", @"E", @"G", @"S", @"W", @"Z"];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return cSections;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [cSections count];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contacts[section] count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return cSections[section];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *contactID = @"contactId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: contactID];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: contactID];
    }
    [cell.textLabel setText: contacts[indexPath.section][indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
