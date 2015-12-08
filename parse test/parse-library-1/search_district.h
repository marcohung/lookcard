//
//  UIViewController+search_district.h
//  parse test
//
//  Created by Marco Hung on 6/2/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface search_district: UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *hki;
    NSMutableArray *hki_head;
    NSMutableArray *kln;
    NSMutableArray *kln_head;
    NSMutableArray *nt;
    NSMutableArray *nt_head;

    NSMutableArray *district_head;
    NSMutableArray *district;
    NSMutableString *selected_district;
    NSIndexPath *selected_indexpath;
}

@property (weak, nonatomic) IBOutlet UITextField *search_text;
- (IBAction)searchbar_finish:(id)sender;
- (IBAction)segmentchange:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITableView *districttablez;


@property (nonatomic, strong) NSString *usersearchinput;
@property (nonatomic, strong) NSString *user_searchdistrict;

@end
