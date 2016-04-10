//
//  ViewController.m
//  parse test
//
//  Created by Marco Hung on 25/12/2014.
//  Copyright (c) 2014年 Ceasar Production. All rights reserved.
//

#import "cardsearch.h"
#import "CardCell.h"
#import "ShowCardDetails.h"

@interface cardsearch ()

@end

@implementation cardsearch



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //passing segue parameter to local parameter
    selectedbank = _selectedbanksegue;
    //init variable
    listz = [[NSMutableArray alloc] init];
    listpic_urlz = [[NSMutableArray alloc] init];
    listpicz = [[NSMutableArray alloc] init];
    listcardcode = [[NSMutableArray alloc] init];
    listowned = [[NSMutableArray alloc] init];
    ownedcard = [[NSMutableArray alloc] init];
    arrayz = [[NSMutableArray alloc] init];
    greentick = [UIImage imageNamed:@"green_tick"];
    blackadd = [UIImage imageNamed:@"black_add"];
    self.imageOperationQueue = [[NSOperationQueue alloc]init];
    self.imageOperationQueue.maxConcurrentOperationCount = 4;
    self.imageCache = [[NSCache alloc] init];
}
-(void)viewDidAppear:(BOOL)animated{
    
    //get all registered owned card in local memory
    path = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
    plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    arrayz = [plist objectForKey:@"card"];
    int i=0;
    ownedcardcount=arrayz.count;
    for (NSMutableDictionary *eachcard in arrayz){
        ownedcard[i]=[eachcard objectForKey:@"card_name"];
        i++;
    }
    
    //query to parse
    PFQuery *query = [PFQuery queryWithClassName:@"creditcard"];
    [query whereKey:@"bank" equalTo:selectedbank];
    [query orderByAscending:@"card"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *ccobjects, NSError *error) {    // Do something with the returned PFObject in the gameScore variable.
        if(!error){
            int i=0;
            for (PFObject *ccobject in ccobjects) {
            //    NSLog(@"%@",ccobject);
                listz[i]=ccobject[@"card"];
                listpic_urlz[i]=ccobject[@"picurl"];
                listpicz[i]=ccobject[@"picurl"];
             //   listpicz[i]=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ccobject[@"picurl"]]]];
                listcardcode[i]=ccobject[@"card_code"];
                listowned[i] = @"NO";
                for (NSString *checkowned in ownedcard) {
                    if ([checkowned isEqualToString:listz[i]]){
                        listowned[i] = @"YES";
                    }
                }
                i++;
            }
        [self.tableviewz reloadData];
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listz.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indicator = @"Cell";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:indicator];
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CardCell" owner:nil options:nil];
        for (UIView *view in views) {
            if ([view isKindOfClass:[CardCell class]]) {
                cell = (CardCell *)view;
            }
        }
    }
    if (listz.count > 0){
        cell.rightLabel.text = listz[indexPath.row];
        if ([listowned[indexPath.row] isEqualToString:@"YES"]){
            cell.ownedbutton.image = greentick;
        }else{
            cell.ownedbutton.image = blackadd;
        }
        UIImage *imageFromCache = [self.imageCache objectForKey:listpicz[indexPath.row]];
        if (imageFromCache) {
            cell.cellpicturez.image = imageFromCache;
        }else{
            cell.cellpicturez.image = [UIImage imageNamed:@"resto_placeholder"];
            [self.imageOperationQueue addOperationWithBlock:^{
                NSURL *imageurl = [NSURL URLWithString:listpicz[indexPath.row]];
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
                if (img != nil) {
                    [self.imageCache setObject:img forKey:listpicz[indexPath.row]]; // update cache
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{  // now update UI in main queue
                        // see if the cell is still visible ... it's possible the user has scrolled the cell so it's no longer visible, but the cell has been reused for another indexPath
                        CardCell *updateCell = (CardCell *)[tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell) {   // if so, update the image
                            [updateCell.cellpicturez setImage:img];
                        }
                    }];
                }
            }];
        }   //dynamic loading restaurant image when scroll, end
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([listowned[indexPath.row] isEqualToString:@"YES"]){
        ownedcardcount--;
        listowned[indexPath.row] = @"NO";
    }else{
        if (ownedcardcount<10){
            listowned[indexPath.row] = @"YES";
            ownedcardcount++;
        }else{
            UIAlertController *cardalertcontroller = [UIAlertController alertControllerWithTitle:@"Limit：10 Cards" message:@"  " preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: nil];
            [cardalertcontroller addAction:okAction];
            [self presentViewController:cardalertcontroller animated:YES completion:nil];
        }
    }
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableviewz reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];
    [self save_card_procedure];

}
- (IBAction)save_card:(id)sender {
    [self save_card_procedure];
}
-(void)save_card_procedure{
    int i=0;
    for (NSString *eachcard in listz){
        if ([listowned[i] isEqualToString:@"YES"]){
            int flagadd = 0;    // check for dulipcation
            for (int j=0; j<arrayz.count; j++) {
                if ([eachcard isEqualToString:[arrayz[j] objectForKey:@"card_name"]]) {
                    flagadd = 1;
                    break;
                }
            }
            if (flagadd == 0){  //add card
                NSDictionary *addtoarrayz = @{@"card_name":eachcard,
                                             @"card_url":listpic_urlz[i],
                                              @"card_code":listcardcode[i]};
                [arrayz addObject:addtoarrayz];
            }
        }else{
            for (int j=0; j<arrayz.count; j++) {
                if ([eachcard isEqualToString:[arrayz[j] objectForKey:@"card_name"]]) {
                    [arrayz removeObjectAtIndex:j];
                }
            }
        }
        i++;
    }
    [plist setObject:arrayz forKey:@"card"];
    [plist writeToFile:path atomically:YES];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"show_addcard_details"]) {
        NSIndexPath *indexPath = sender;
        ShowCardDetails *destViewController = segue.destinationViewController;
        destViewController.selectedcardsegue = listz[indexPath.row];
    }
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier: @"show_addcard_details" sender: indexPath];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];        // Dispose of any resources that can be recreated.
}


@end
