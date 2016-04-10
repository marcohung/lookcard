//
//  UITableViewController+banksearch.m
//  parse test
//
//  Created by Marco Hung on 27/12/2014.
//  Copyright (c) 2014" Ceasar Production. All rights reserved.
//

#import "bank_search.h"
#import "CustomCell.h"
#import "cardsearch.h"

@implementation bank_search
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    banklistz = [[NSMutableArray alloc] init];
    banklistcnamez = [[NSMutableArray alloc] init];
    banklistlogourlz = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"bank"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *ccobjects, NSError *error) {    // Do something with the returned PFObject in the gameScore variable.
        if(!error){
            int i=0;
            for (PFObject *ccobject in ccobjects) {
                banklistz[i]=ccobject[@"bankname"];
                banklistcnamez[i]=ccobject[@"bankchinesename"];
                banklistlogourlz[i]=[UIImage imageNamed:ccobject[@"bankname"]];
                i++;
            }
            [self.banksearchtableviewz reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return banklistz.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indicator = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:indicator];
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        for (UIView *view in views) {
            if ([view isKindOfClass:[CustomCell class]]) {
                cell = (CustomCell *)view;
            }
        }
    }
    if (banklistz.count > 0){
        cell.cellpicturez.image =banklistlogourlz[indexPath.row];
        cell.rightLabel.text = banklistcnamez[indexPath.row];
        cell.green_bg.hidden=YES;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
//segue action
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier: @"banktocard" sender: self];
}
// passing parameter through segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"banktocard"]) {
        NSIndexPath *indexPath = [self.banksearchtableviewz indexPathForSelectedRow];
        cardsearch *destViewController = segue.destinationViewController;
        destViewController.selectedbanksegue = banklistz[indexPath.row];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
