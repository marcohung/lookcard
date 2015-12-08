//
//  UIViewController+my_fav.m
//  parse test
//
//  Created by Marco Hung on 13/2/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "my_fav.h"
#import "restaurant_detail_page.h"

@implementation my_fav
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationItem setTitle:@"我的收藏"];
    path = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
    self.fav_empty_label.hidden=YES;
    
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
    if (shopz == nil){
        shopz = [[NSMutableArray alloc] init];
        addressz = [[NSMutableArray alloc] init];
        descriptionz = [[NSMutableArray alloc] init];
        picurl = [[NSMutableArray alloc] init];
        cardbank = [[NSMutableArray alloc] init];
        rest_ParseObjectid = [[NSMutableArray alloc] init];
    }else{
        NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];;
        for(int i=0;i<shopz.count;i++){
            deleteIndexPaths[i] = [NSIndexPath indexPathForRow:i inSection:0];
        }
        UITableView *tv = (UITableView *)self.fav_searchtablez;
        numberofcell=0;
        
        [shopz removeAllObjects];
        [addressz removeAllObjects];
        [descriptionz removeAllObjects];
        [cardbank removeAllObjects];
        [picurl removeAllObjects];
        [rest_ParseObjectid removeAllObjects];
        [tv beginUpdates];
        [tv deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [tv endUpdates];
        
    }
    //init variable
    pagecounter = 1;
    sectiontodisplay=1;
    realtableend = NO;
    numberofcell = 0;
    lastcellinparse = 0;
    NSLog(@"rest module");
    self.fav_rotor.hidden = NO;
    [self.fav_rotor startAnimating];
    
    plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    fav_rest_array = [plist objectForKey:@"fav_rest_id"];
    [self viewinitaltable];
}
-(void)viewinitaltable{
    //build query to parse system
    PFQuery *query = [PFQuery queryWithClassName:@"database20150712222"];
    [query whereKey:@"objectId" containedIn:fav_rest_array];
    [query orderByAscending:@"restaurant"];
    query.limit = 100;
    [query findObjectsInBackgroundWithBlock:^(NSArray *ccobjects, NSError *error) {
        if(!error){
            for (PFObject *ccobject in ccobjects) {
                if (([lastshopname isEqualToString:ccobject[@"restaurant"]])&&([lastshopcardbank isEqualToString:ccobject[@"cardbank"]])){
                    NSInteger multishopcount = [multishop[numberofcell-1] integerValue];
                    multishop[numberofcell-1]=[NSNumber numberWithInt: (int)multishopcount + 1];
                }else{
                    if (numberofcell>19){
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
                    NSString *temps = [NSString stringWithFormat:@"%@%@",@"http://cardshk.com/cardsapp/picture/restaurant/allrestpic/",ccobject[@"picture"]];
                    picurl[numberofcell]=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:temps]]];
                    numberofcell++;
                    
                    lastshopname=ccobject[@"restaurant"];
                    lastshopcardbank=ccobject[@"cardbank"];
                }
                lastcellinparse++;
                
            }

            if (numberofcell<20)
                realtableend=YES;
            if (numberofcell == 0)
            {
                self.fav_empty_label.hidden=NO;
                self.fav_rotor.hidden=YES;
            }else{
                self.fav_empty_label.hidden=YES;
            }
            //insert row with aminiation
            NSMutableArray *arrayOfIndexPaths = [[NSMutableArray alloc] init];
            NSIndexPath *insertpath = [[NSIndexPath alloc] init];
            for(int i = 0   ; i < numberofcell ; i++)
            {
                insertpath = [NSIndexPath indexPathForRow:i inSection:0];
                [arrayOfIndexPaths addObject:insertpath];
            }
            [self.fav_searchtablez beginUpdates];
            [self.fav_searchtablez insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationTop];
            [self.fav_searchtablez endUpdates];
            
        }
    }];
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
    cell.cellpicturez.image= picurl[indexPath.row];
    cell.rightLabel.text=shopz[indexPath.row];
    NSString *html = [NSString stringWithFormat:@"%@%@%@",@"<span style=\"font-size:10px;\">",descriptionz[indexPath.row],@"</span>"];
    [cell.cellwebz loadHTMLString:html baseURL:nil];
    cell.bankimagez.image=cardbank[indexPath.row];
    if([multishop[indexPath.row] integerValue]>1){
        cell.celladdressz.text=@"多間分店";
    }else{
        cell.celladdressz.text=addressz[indexPath.row];
    }

    
    return cell;
}

//detect the end of table and ask for extra 20 cells
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if  (indexPath.row == (numberofcell-1)) {
        // This is the last cell
        if (!realtableend){
            [self loadextra20];
        }
        else{
            [self.fav_rotor stopAnimating];
            self.fav_rotor.hidden=YES;
        }
    }
}

//method that loads extra 20 cells from datebase
-(void)loadextra20
{
    //build query to parse system
    PFQuery *query = [PFQuery queryWithClassName:@"database20150712222"];
    [query whereKey:@"objectId" containedIn:fav_rest_array];
    [query orderByAscending:@"restaurant"];
    query.skip=numberofcell;
    query.limit = 20;
    __block int startposition = (int)numberofcell;
    [query findObjectsInBackgroundWithBlock:^(NSArray *ccobjects, NSError *error) {
        if(!error){
            for (PFObject *ccobject in ccobjects) {
                if (([lastshopname isEqualToString:ccobject[@"restaurant"]])&&([lastshopcardbank isEqualToString:ccobject[@"cardbank"]])){
                    NSInteger multishopcount = [multishop[numberofcell-1] integerValue];
                    multishop[numberofcell-1]=[NSNumber numberWithInt: (int)multishopcount + 1];
                }else{
                    if (numberofcell-startposition>19){
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
                    cardbank[numberofcell]=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cardshk.com/cardsapp/picture/card/bank/full/full_%@.png",ccobject[@"cardbank"]]]]];
                    NSString *temps = [NSString stringWithFormat:@"%@%@%@%@",@"http://cardshk.com/cardsapp/picture/restaurant/",ccobject[@"cardbank"],@"/",ccobject[@"picture"]];
                    picurl[numberofcell]=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:temps]]];
                    numberofcell++;
                    
                    lastshopname=ccobject[@"restaurant"];
                    lastshopcardbank=ccobject[@"cardbank"];
                }
                NSLog(@"%@, %li",shopz[numberofcell-1],(long)[multishop[numberofcell-1] integerValue]);
                lastcellinparse++;
            }
            NSLog(@" numberofcell:%li lastcellinparse:%li", numberofcell, (long)lastcellinparse);
            if ((numberofcell-startposition)<20)
                realtableend=YES;
            NSMutableArray *arrayOfIndexPaths = [[NSMutableArray alloc] init];
            NSIndexPath *insertpath = [[NSIndexPath alloc] init];
            for(int i = startposition ; i < numberofcell ; i++)
            {
                insertpath = [NSIndexPath indexPathForRow:i inSection:0];
                [arrayOfIndexPaths addObject:insertpath];
            }
            [self.fav_searchtablez beginUpdates];
            [self.fav_searchtablez insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationTop];
            [self.fav_searchtablez endUpdates];
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"fav_show_restaurant_details" sender: indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"fav_show_restaurant_details"]) {
        //prepare data from sender
        NSIndexPath *senderindexpath = [[NSIndexPath alloc]init];
        senderindexpath = sender;
        //pass data to new view
        restaurnat_detail_page *destViewController = segue.destinationViewController;
        destViewController.rest_objectid = rest_ParseObjectid[senderindexpath.row];
        destViewController.rest_multishop = multishop[senderindexpath.row];
        [self.parentViewController.parentViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
