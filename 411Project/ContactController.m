//
//  ContactController.m
//  411Project
//
//  Created by Yanyi Mei on 11/9/13.
//  Copyright (c) 2013 Yanyi Mei. All rights reserved.
//

#import "ContactController.h"

@interface ContactController ()

@end

@implementation ContactController
@synthesize contacts;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    NSDictionary *temp = [NSMutableDictionary dictionaryWithContentsOfFile: path];
    self.contacts = [NSMutableArray arrayWithArray:[temp allValues]];
    NSLog(@"%lu", [self.contacts count]);
    
    self.cAlpha = [self makecAlpha: self.contacts];
    self.contactTable.tableHeaderView = self.contactSearch;
    //self.searchDisplayController.searchResultsTableView.tableHeaderView = self.contactSearch;
    self.contactTable.contentOffset = CGPointMake(0, CGRectGetHeight(self.contactSearch.bounds));
    self.filteredC = [NSMutableArray arrayWithCapacity:[self.contacts count]];
    self.cSearchTable.searchResultsTitle = @"Search Results";
}

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (animated) {
        [self.contactTable flashScrollIndicators];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.contactTable)
    {
        NSArray *keys = [self.cAlpha allKeys];
        return [keys count];
    }
    else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.contactTable)
    {
        NSArray *unsortedA = [self.cAlpha allKeys];
        NSArray *sorted = [unsortedA sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSString *key = [sorted objectAtIndex:section];
        NSArray *aForSection = [self.cAlpha objectForKey:key];
        return [aForSection count];
    }
    else
    {
        return [self.filteredC count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (tableView == self.contactTable)
    {
        NSArray *unsortedKeys = [self.cAlpha allKeys];
        NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSString *key = [sortedKeys objectAtIndex:[indexPath section]];
        NSArray *aForSection = [self.cAlpha objectForKey:key];
        NSString *a = [aForSection objectAtIndex:[indexPath row]];
        [cell.textLabel setText:a];
    }
    else
    {
        [cell.textLabel setText: [self.filteredC objectAtIndex:indexPath.row]];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(tableView == self.contactTable)
    {
        NSArray *keys = [[self.cAlpha allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSString *key = [keys objectAtIndex:section];
        return key;
    }
    else
    {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - section index config

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.contactTable)
    {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    }
    else
    {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == self.contactTable){
        if (index == 0) [self.contactSearch becomeFirstResponder];
        NSArray *unsortedA = [self.cAlpha allKeys];
        NSArray *sorted = [unsortedA sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSArray *alphabet = [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
        NSUInteger ret = [sorted indexOfObject: [alphabet objectAtIndex: index]];
        if (ret>[alphabet count]) ret = 0;
        return ret;
    }
    else
    {
        return 0;
    }
}

#pragma mark - Search bar.

- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    [self.contactTable scrollRectToVisible:self.contactSearch.frame animated:animated];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.filteredC = nil;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSArray *temp = [NSMutableArray arrayWithArray: [self.contacts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchString]]];
    self.filteredC = [[temp sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    return YES;
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSArray *temp = [NSMutableArray arrayWithArray: [self.contacts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText]]];
    self.filteredC = [[temp sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"You have a cancell;)");
    [self.cSearchTable setActive:NO];
    [self.contactSearch resignFirstResponder];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    searchBar.text = @"";
//    NSLog(@"You have a cancell;)");
//    [self.contactSearch resignFirstResponder];
//    [searchBar setShowsCancelButton:NO animated:YES];
//    self.contactTable.allowsSelection = YES;
//    self.contactTable.scrollEnabled = YES;
//    [self.filteredC removeAllObjects];
//    //[self.filteredC addObjectsFromArray:];
//    [self.contactTable reloadData];
//}
@end
