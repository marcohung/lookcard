//
//  UIViewController+showcarddetails.m
//  parse test
//
//  Created by Marco Hung on 31/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "rest_addresslist.h"

@implementation rest_addresslist

- (void)viewDidLoad {
    [super viewDidLoad];
    address_list = [[NSMutableArray alloc] init];
    NSLog(@"%@",self.rest_address_name_z);
    NSLog(@"%@",self.rest_address_cardbank_z);
    self.navigationItem.title = self.rest_address_name_z;
    
}
- (void)viewDidAppear:(BOOL)animated{
    //query to parse
    PFQuery *query = [PFQuery queryWithClassName:@"database20150712222"];
    [query whereKey:@"cardbank" equalTo:self.rest_address_cardbank_z];
    [query whereKey:@"restaurant" equalTo:self.rest_address_name_z];
    [query orderByAscending:@"address"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *ccobjects, NSError *error) {
        if(!error){
            int i=0;
            for (PFObject *ccobject in ccobjects) {
                address_list[i]=ccobject[@"address"];
                NSLog(@"%@",address_list[i]);
                i++;
            }
           [self.address_tableviewz reloadData];
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return address_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellz"];
    cell.textLabel.text=address_list[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
