//
//  UIViewController+restaurantsearch.h
//  parse test
//
//  Created by Marco Hung on 12/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchcell.h"
#import <Parse/Parse.h>

@interface restaurantsearch : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
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
    NSString *cousine;
    NSString *path;
    NSMutableDictionary *plist;
    NSMutableArray *mycardlistz;
    
    NSMutableArray *queryarray;
    PFQuery *query_rest;
    PFQuery *query_address;
    NSInteger lastcellinparse;
    NSString *lastshopname; //check for uniqueness
    NSString *lastshopcardbank;

}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *rotor;
@property (weak, nonatomic) IBOutlet UITableView *searchtablez;
@property (weak, nonatomic) IBOutlet UITextField *searchfieldz;
- (IBAction)searchfield_touch:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cousine_seg_con;

@property (nonatomic, strong) NSString *usersearchinput;
@property (nonatomic, strong) NSString *user_searchdistrict;
@property (weak, nonatomic) IBOutlet UILabel *no_result_label;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;
@property (nonatomic, strong) NSCache *imageCache;
- (IBAction)cousine_input:(UISegmentedControl *)sender;

@end
