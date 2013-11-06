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
    NSDictionary *cAlpha;
    NSArray *contacts;
    __weak IBOutlet UITableView *contactTable;
}
@end

@implementation SecondViewController
//@synthesize contacts;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    contacts = @[@"Zombie Pigman", @"Blaze", @"Creeper", @"Ender", @"Ghast", @"Steve", @"Skeleton", @"Slime", @"Wither Skeleton", @"Villager", @"Zombie"];
    cAlpha = [self makecAlpha: contacts];
}

//Helper fcn for generating cALpha
- (NSDictionary *)makecAlpha:(NSArray *)thisContact {
    NSMutableDictionary *buffer = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < [thisContact count]; i++) {
        NSString *item = [thisContact objectAtIndex:i];
        NSString *firstLetter = [[item substringToIndex:1] uppercaseString];
        if ([buffer objectForKey:firstLetter]) {
            [(NSMutableArray *)[buffer objectForKey:firstLetter] addObject:item];
        }
        else {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:item, nil];
            [buffer setObject:mutableArray forKey:firstLetter];
        }
    }
    NSArray *keys = [buffer allKeys];
    for (int j = 0; j < [keys count]; j++) {
        NSString *key = [keys objectAtIndex:j];
        [(NSMutableArray *)[buffer objectForKey:key] sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    NSDictionary *result = [NSDictionary dictionaryWithDictionary:buffer];
    return result;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *keys = [cAlpha allKeys];
    return [keys count];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *unsortedA = [cAlpha allKeys];
    NSArray *sorted = [unsortedA sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sorted objectAtIndex:section];
    NSArray *aForSection = [cAlpha objectForKey:key];
    return [aForSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Fetch Fruit
    NSArray *unsortedKeys = [cAlpha allKeys];
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedKeys objectAtIndex:[indexPath section]];
    NSArray *aForSection = [cAlpha objectForKey:key];
    NSString *a = [aForSection objectAtIndex:[indexPath row]];
    [cell.textLabel setText:a];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [[cAlpha allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [keys objectAtIndex:section];
    return key;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//The configuration for section index data
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSArray *unsortedA = [cAlpha allKeys];
    NSArray *sorted = [unsortedA sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *alphabet = [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    NSUInteger ret = [sorted indexOfObject:[alphabet objectAtIndex: index]];
    if (ret>26) ret = 0;// -1 because we add the search symbol
    return ret;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
