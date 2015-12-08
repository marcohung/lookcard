//
//  UIViewController+showcarddetails.h
//  parse test
//
//  Created by Marco Hung on 31/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface rest_addresslist : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSString *rest_address_name;
    NSMutableArray *address_list;
}
@property (weak, nonatomic) IBOutlet UITableView *address_tableviewz;
@property (nonatomic, strong) NSString *rest_address_name_z;
@property (nonatomic, strong) NSString *rest_address_cardbank_z;
@end
