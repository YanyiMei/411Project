//
//  ContactController.h
//  411Project
//
//  Created by Yanyi Mei on 11/9/13.
//  Copyright (c) 2013 Yanyi Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactController : UITableViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
    @property (nonatomic, strong)NSMutableArray *contacts;
    @property (nonatomic, strong)NSDictionary *cAlpha;
    @property (nonatomic, strong)NSMutableArray *filteredC;
    @property (strong, nonatomic) IBOutlet UITableView *contactTable;
    @property (strong, nonatomic) IBOutlet UISearchBar *contactSearch;
    @property (strong, nonatomic) IBOutlet UISearchDisplayController *cSearchTable;
@end
