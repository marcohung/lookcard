//
//  UITableViewController+banksearch.h
//  parse test
//
//  Created by Marco Hung on 27/12/2014.
//  Copyright (c) 2014年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface bank_search: UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *banklistz;
    NSMutableArray *banklistcnamez;
    NSMutableArray *banklistlogourlz;
}
@property (strong, nonatomic) IBOutlet UITableView *banksearchtableviewz;
@end
