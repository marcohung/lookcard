//
//  UIViewController+my_fav.h
//  parse test
//
//  Created by Marco Hung on 13/2/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchcell.h"
#import <Parse/Parse.h>

@interface my_fav : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    NSMutableArray *shopz;
    NSMutableArray *addressz;
    NSMutableArray *descriptionz;
    NSMutableArray *picurl;
    NSMutableArray *cardbank;
    NSMutableArray *rest_ParseObjectid;
    NSMutableArray *multishop;
    int pagecounter;
    unsigned long numberofcell;
    NSPredicate *predicate;
    bool realtableend;
    int sectiontodisplay;
    
    NSString *path;
    NSMutableDictionary *plist;
    NSMutableArray *fav_rest_array;
    NSInteger lastcellinparse;
    NSString *lastshopname; //check for uniqueness
    NSString *lastshopcardbank;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *fav_rotor;
@property (weak, nonatomic) IBOutlet UILabel *fav_empty_label;
@property (weak, nonatomic) IBOutlet UITableView *fav_searchtablez;
@end
