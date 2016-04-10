//
//  UIViewController+restaurantsearch.m
//  parse test
//
//  Created by Marco Hung on 12/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "restaurantsearch.h"
#import "searchcell.h"
#import "search_district.h"
#import "restaurant_detail_page.h"

@implementation restaurantsearch
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:NO];
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    cousine = @"所有菜式";
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://cardshk.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (!data){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Cellular Data is Turned Off" message:@"Turn on cellular data or use Wi-Fi to access data." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *SettingAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", @"OpenSetting") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // jump to setting when no internet is detected
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alertController addAction:SettingAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self firstaction];
    };
}

-(void)firstaction{
    Boolean havechange = false;
    //reload page after cards are changed by user
    path = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
    plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *newcardlistz;
    newcardlistz = [plist objectForKey:@"card"];
    if (mycardlistz.count ==0){
        havechange=true;    //first time running restaurant tab is executed thr here
    }else if (newcardlistz.count>0){
        if(newcardlistz.count == mycardlistz.count){
            for (int i=0;i<newcardlistz.count;i++){
                if (![[newcardlistz[i] objectForKey:@"card_code"] isEqualToString:[mycardlistz[i] objectForKey:@"card_code"]]) {
                    havechange=true;    //same number of card, card changed, reload data
                    break;
                }
            }
        }else{
            havechange=true;    //same number of card, card changed, reload data
        }
    }
    if (havechange){
        mycardlistz=newcardlistz;
        [self resettable];
        [self viewinitaltable];
    }
}

-(void)resettable{
    self.cousine_seg_con.enabled=NO;
    if (shopz == nil){
        shopz = [[NSMutableArray alloc] init];
        addressz = [[NSMutableArray alloc] init];
        descriptionz = [[NSMutableArray alloc] init];
        picurl = [[NSMutableArray alloc] init];
        cardbank = [[NSMutableArray alloc] init];
        rest_ParseObjectid = [[NSMutableArray alloc] init];
        multishop = [[NSMutableArray alloc] init];
    }else{
        NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];;
        for(int i=0;i<shopz.count;i++){
            deleteIndexPaths[i] = [NSIndexPath indexPathForRow:i inSection:0];
        }
        UITableView *tv = (UITableView *)self.searchtablez;
        numberofcell=0;
        [shopz removeAllObjects];
        [addressz removeAllObjects];
        [descriptionz removeAllObjects];
        [cardbank removeAllObjects];
        [picurl removeAllObjects];
        [rest_ParseObjectid removeAllObjects];
        [multishop removeAllObjects];
        [self.imageCache removeAllObjects];
        [tv beginUpdates];
        [tv deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [tv endUpdates];
    }
    self.imageOperationQueue = [[NSOperationQueue alloc]init];
    self.imageOperationQueue.maxConcurrentOperationCount = 4;
    self.imageCache = [[NSCache alloc] init];
    //init variable
    pagecounter = 1;
    sectiontodisplay=1;
    realtableend = NO;
    numberofcell = 0;
    lastcellinparse = 0;
    lastshopname = @"";
    self.no_result_label.hidden=YES;
    self.rotor.hidden = NO;
    [self.rotor startAnimating];
    
    //prepare search variable and textfield
    if ([self.user_searchdistrict length]>0){
        self.searchfieldz.text = [NSString stringWithFormat:@"District:%@",self.user_searchdistrict];
    };
    if ([self.usersearchinput length]>0){
        self.searchfieldz.text = [NSString stringWithFormat:@"%@, Name/Address:%@",self.searchfieldz.text, self.usersearchinput];
    }
    
}
-(void)viewinitaltable{
    
    path = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
    plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    mycardlistz = [plist objectForKey:@"card"];
    queryarray = [[NSMutableArray alloc] init];

    for (int i=0; i<mycardlistz.count; i++) {
        queryarray[i] = [PFQuery queryWithClassName:@"database20150712222"];
        [queryarray[i] whereKey:@"card_code" matchesRegex:[mycardlistz[i] objectForKey:@"card_code"] modifiers:@"i"];
    }
   
    switch (mycardlistz.count) {
        case 0:{
            query_rest = [PFQuery queryWithClassName:@"database20150712222"];
            query_address = [PFQuery queryWithClassName:@"database20150712222"];
            break;
        }
        case 1:{
            query_rest = queryarray[0];
            query_address = queryarray[0];
            break;
        }
        case 2:{
            query_rest = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1]]];
            query_address = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1]]];
            break;
        }
        case 3:{
            query_rest = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2]]];
            query_address = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2]]];
            break;
        }
        case 4:{
            query_rest = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3]]];
            query_address = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3]]];
            break;
        }
        case 5:{
            query_rest = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4]]];
            query_address = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4]]];
            break;
        }
        case 6:{
            query_rest = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4],queryarray[5]]];
            query_address = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4],queryarray[5]]];
            break;
        }
        case 7:{
            query_rest = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4],queryarray[5],queryarray[6]]];
            query_address = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4],queryarray[5],queryarray[6]]];
            break;
        }
        case 8:{
            query_rest = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4],queryarray[5],queryarray[6],queryarray[7]]];
            query_address = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4],queryarray[5],queryarray[6],queryarray[7]]];
            break;
        }
        case 9:{
            query_rest = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4],queryarray[5],queryarray[6],queryarray[7],queryarray[8]]];
            query_address = [PFQuery orQueryWithSubqueries:@[queryarray[0],queryarray[1],queryarray[2],queryarray[3],queryarray[4],queryarray[5],queryarray[6],queryarray[7],queryarray[8]]];
            break;
        }
        default:{
            query_rest = [PFQuery queryWithClassName:@"database20150712222"];
            query_address = [PFQuery queryWithClassName:@"database20150712222"];
        break;
        }
    }
    
    if ([self.usersearchinput length]>0){
        [query_rest whereKey:@"restaurant" containsString:self.usersearchinput];
        [query_address whereKey:@"address" containsString:self.usersearchinput];
    };
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[query_rest,query_address]];
    if ([self.user_searchdistrict length]>0){
        if ([self.user_searchdistrict isEqualToString:@"香港島(全部)"]){
            [query whereKey:@"area" equalTo:@"香港"];
        }else if ([self.user_searchdistrict isEqualToString:@"九龍(全部)"]){
            [query whereKey:@"area" equalTo:@"九龍"];
        }else if ([self.user_searchdistrict isEqualToString:@"新界(全部)"]){
            [query whereKey:@"area" equalTo:@"新界"];
        }else if ([self.user_searchdistrict isEqualToString:@"全香港"]){
        }else{
            [query whereKey:@"district" equalTo:self.user_searchdistrict];
        }
    };
    
    if (![cousine isEqualToString:@"所有菜式"]){
        [query whereKey:@"cousine" equalTo:cousine];
    };
    
    [query orderByAscending:@"restaurant"];
    query.limit = 1000;
    [query findObjectsInBackgroundWithBlock:^(NSArray *ccobjects, NSError *error) {
        if(!error){
            for (PFObject *ccobject in ccobjects) {
                if (([lastshopname isEqualToString:ccobject[@"restaurant"]])&&([lastshopcardbank isEqualToString:ccobject[@"cardbank"]])){
                    NSInteger multishopcount = [multishop[numberofcell-1] integerValue];
                    multishop[numberofcell-1]=[NSNumber numberWithInt: (int)multishopcount + 1];
                }else{
                    if (numberofcell>99){
                        break;
                    }
                    shopz[numberofcell]=ccobject[@"restaurant"];
                    [multishop addObject: [NSNumber numberWithInt: 1]];
                    if ([ccobject[@"address"] length]>0){
                        addressz[numberofcell]=ccobject[@"address"];
                    }else{
                        addressz[numberofcell]=@"";
                    }
                    descriptionz[numberofcell]=ccobject[@"description"];
                    rest_ParseObjectid[numberofcell]=[ccobject objectId];
                    cardbank[numberofcell]=[UIImage imageNamed:[NSString stringWithFormat:@"full_%@",ccobject[@"cardbank"]]];
                    NSString *imageUrlString = [NSString stringWithFormat:@"%@%@",@"http://cardshk.com/cardsapp/picture/restaurant/allrestpic/",ccobject[@"picture"]];
                    picurl[numberofcell]=imageUrlString;
                    numberofcell++;
                    lastshopname=ccobject[@"restaurant"];
                    lastshopcardbank=ccobject[@"cardbank"];
                }
                NSLog(@"%@, %li",shopz[numberofcell-1],(long)[multishop[numberofcell-1] integerValue]);
                lastcellinparse++;

            }
            NSLog(@"numberofcell:%li lastcellinparse:%li", numberofcell, (long)lastcellinparse);
            if (numberofcell<100)
                realtableend=YES;
            if (numberofcell == 0){
                self.no_result_label.hidden=NO;
                self.rotor.hidden = YES;
            }
            //insert row with aminiation
            NSMutableArray *arrayOfIndexPaths = [[NSMutableArray alloc] init];
            NSIndexPath *insertpath = [[NSIndexPath alloc] init];
            for(int i = 0   ; i < numberofcell ; i++)
            {
                insertpath = [NSIndexPath indexPathForRow:i inSection:0];
                [arrayOfIndexPaths addObject:insertpath];
            }
            [self.searchtablez beginUpdates];
            [self.searchtablez insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationTop];
            [self.searchtablez endUpdates];
        }
        else{
            if(error.code==154){
                self.no_result_label.hidden=NO;
                self.no_result_label.text=@"查詢次數過多，請等侯30秒再試";
                self.rotor.hidden = YES;
            }
        }
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval:5];      // wait 5 seconds, let all image load, prevent user reload too frequent
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cousine_seg_con.enabled=YES;   //upadte the UI in main thread
        });
    });
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberofcell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indicator = @"cells";
    // 自定儲存格類別 setup
    searchcell *cell = [tableView dequeueReusableCellWithIdentifier:indicator];
    if (cell == nil) {
        // 載入 CustomCell.xib 檔
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"searchcell" owner:nil options:nil];
        for (UIView *view in views) {
            if ([view isKindOfClass:[searchcell class]]) {
                cell = (searchcell *)view;
            }
        }
    }
    cell.rightLabel.text=shopz[indexPath.row];
    cell.celldetailz.text=descriptionz[indexPath.row];
    NSString *html = [NSString stringWithFormat:@"%@%@%@",@"<span style=\"font-size:10px;\">",descriptionz[indexPath.row],@"</span>"];
    [cell.cellwebz loadHTMLString:html baseURL:nil];
    cell.bankimagez.image=cardbank[indexPath.row];
    if([multishop[indexPath.row] integerValue]>1){
        cell.celladdressz.text=@"Multiple Branch";
    }else{
        cell.celladdressz.text=addressz[indexPath.row];
    }
    
    //dynamic loading restaurant image when scroll, start
    UIImage *imageFromCache = [self.imageCache objectForKey:picurl[indexPath.row]];
    if (imageFromCache) {
        cell.cellpicturez.image = imageFromCache;
    }else{
        cell.cellpicturez.image = [UIImage imageNamed:@"resto_placeholder"];
        [self.imageOperationQueue addOperationWithBlock:^{
            NSURL *imageurl = [NSURL URLWithString:picurl[indexPath.row]];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
            if (img != nil) {
                [self.imageCache setObject:img forKey:picurl[indexPath.row]];   // update cache
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{  // now update UI in main queue
                    // see if the cell is still visible ... it's possible the user has scrolled the cell so it's no longer visible, but the cell has been reused for another indexPath
                    searchcell *updateCell = (searchcell *)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell) {   // if so, update the image
                        [updateCell.cellpicturez setImage:img];
                    }
                }];
            }
        }];
    }
    return cell;   //dynamic loading restaurant image when scroll, end
}

//detect the end of table and ask for extra 100 cells
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if  (indexPath.row == (numberofcell-1)) {
        if (!realtableend){ // This is the last cell
            [self loadextra20];
        }
        else{
            [self.rotor stopAnimating];
            self.rotor.hidden=YES;
        }
    }
}

-(void)loadextra20  //method that loads extra 100 cells from datebase
{
    self.cousine_seg_con.enabled=NO;
    //build query to parse system
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[query_rest,query_address]];
    if ([self.user_searchdistrict length]>0){
        if ([self.user_searchdistrict isEqualToString:@"香港島(全部)"]){
            [query whereKey:@"area" equalTo:@"香港"];
        }else if ([self.user_searchdistrict isEqualToString:@"九龍(全部)"]){
            [query whereKey:@"area" equalTo:@"九龍"];
        }else if ([self.user_searchdistrict isEqualToString:@"新界(全部)"]){
            [query whereKey:@"area" equalTo:@"新界"];
        }else if ([self.user_searchdistrict isEqualToString:@"全香港"]){
        }else{
            [query whereKey:@"district" equalTo:self.user_searchdistrict];
        }
    };
    if (![cousine isEqualToString:@"所有菜式"]){
        [query whereKey:@"cousine" equalTo:cousine];
    };
    
    [query orderByAscending:@"restaurant"];
    query.skip=lastcellinparse;
    query.limit = 1000;
    __block int startposition = (int)numberofcell;
    [query findObjectsInBackgroundWithBlock:^(NSArray *ccobjects, NSError *error) {
        if(!error){
            for (PFObject *ccobject in ccobjects) {
                if (([lastshopname isEqualToString:ccobject[@"restaurant"]])&&([lastshopcardbank isEqualToString:ccobject[@"cardbank"]])){
                    NSInteger multishopcount = [multishop[numberofcell-1] integerValue];
                    multishop[numberofcell-1]=[NSNumber numberWithInt: (int)multishopcount + 1];
                }else{
                    if (numberofcell-startposition>99){
                        break;
                    }
                    shopz[numberofcell]=ccobject[@"restaurant"];
                    [multishop addObject: [NSNumber numberWithInt: 1]];
                    if ([ccobject[@"address"] length]>0){
                        addressz[numberofcell]=ccobject[@"address"];
                    }else{
                        addressz[numberofcell]=@"";
                    };
                    descriptionz[numberofcell]=ccobject[@"description"];
                    rest_ParseObjectid[numberofcell]=[ccobject objectId];
                    cardbank[numberofcell]=[UIImage imageNamed:[NSString stringWithFormat:@"full_%@",ccobject[@"cardbank"]]];
                    NSString *imageUrlString = [NSString stringWithFormat:@"%@%@",@"http://cardshk.com/cardsapp/picture/restaurant/allrestpic/",ccobject[@"picture"]];
                    picurl[numberofcell]=imageUrlString;
                    numberofcell++;
                    lastshopname=ccobject[@"restaurant"];
                    lastshopcardbank=ccobject[@"cardbank"];
                }
                NSLog(@"%@, %li",shopz[numberofcell-1],(long)[multishop[numberofcell-1] integerValue]);
                lastcellinparse++;
            }
            NSLog(@" numberofcell:%li lastcellinparse:%li", numberofcell, (long)lastcellinparse);
            if ((numberofcell-startposition)<100)
                realtableend=YES;
            NSMutableArray *arrayOfIndexPaths = [[NSMutableArray alloc] init];
            NSIndexPath *insertpath = [[NSIndexPath alloc] init];
            for(int i = startposition ; i < numberofcell ; i++){
                insertpath = [NSIndexPath indexPathForRow:i inSection:0];
                [arrayOfIndexPaths addObject:insertpath];
            }
            [self.searchtablez beginUpdates];
            [self.searchtablez insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationTop];
            [self.searchtablez endUpdates];
        }
        else{
            NSLog(@"ERRORRRRRR: %@, ssss,%li",error,(long)error.code);
            if(error.code==154){
                self.no_result_label.hidden=NO;
                self.no_result_label.text=@"查詢次數過多，請等侯30秒再試";
                self.rotor.hidden = YES;
            }
        }
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval:5];      // wait 5 seconds, let all image load, prevent user reload too frequent
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cousine_seg_con.enabled=YES;   //upadte the UI in main thread
        });
    });
}
//search button link to segue
- (IBAction)searchfield_touch:(id)sender {
    [self performSegueWithIdentifier: @"details_search" sender: self];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"show_restaurant_details" sender: indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"details_search"]) {
        search_district *destViewController = segue.destinationViewController;
        destViewController.usersearchinput = self.usersearchinput;
        destViewController.user_searchdistrict= self.user_searchdistrict;
    } else if ([segue.identifier isEqualToString:@"show_restaurant_details"]) {
        NSIndexPath *senderindexpath = [[NSIndexPath alloc]init];   //prepare data from sender
        senderindexpath = sender;
        restaurnat_detail_page *destViewController = segue.destinationViewController;   //pass data to new view
        destViewController.rest_objectid = rest_ParseObjectid[senderindexpath.row];
        destViewController.rest_multishop = multishop[senderindexpath.row];
        [self.parentViewController.parentViewController dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    // Dispose of any resources that can be recreated.
}

- (IBAction)cousine_input:(UISegmentedControl *)sender {
    cousine = [NSString stringWithFormat:@"%@",[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]];
    [self resettable];
    [self viewinitaltable];
}
@end
