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
    __weak IBOutlet UITableView *contactTable;
}
@end

@implementation SecondViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    contacts = @[@"Steve", @"Creeper", @"Zombie", @"Zombie Pigman", @"Skull", @"Wither Skull", @"Ender", @"Blaze", @"Ghast", @"Slime"];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contacts count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *contactID = @"contactId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: contactID];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: contactID];
    }
    cell.textLabel.text = [contacts objectAtIndex: indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
