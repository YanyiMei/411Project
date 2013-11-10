//
//  FirstViewController.m
//  411Project
//
//  Created by Yanyi Mei on 11/4/13.
//  Copyright (c) 2013 Yanyi Mei. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *pollTable;
    NSArray *polls;
    NSArray *pSections;
    
}
    

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    polls = @[@"Poll1", @"Poll2", @"Poll3", @"Poll4", @"Poll5", @"Poll6", @"Poll7", @"Poll8", @"Poll9", @"Poll10"];
    pSections = @[@"tag1", @"tag2", @"tag3", @"tag4"];
}

#pragma mark - Cell generation.

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [polls count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pollID = @"pollId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: pollID];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: pollID];
    }
    [cell.textLabel setText: polls[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Possible further changes: adding a sort by tag: see polls in differnent tables???

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
