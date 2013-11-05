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
    
}
    

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    polls = @[@"Poll1", @"Poll2", @"Poll3", @"Poll4", @"Poll5", @"Poll6", @"Poll7", @"Poll8", @"Poll9", @"Poll10"];
}

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
    cell.textLabel.text = [polls objectAtIndex: indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
