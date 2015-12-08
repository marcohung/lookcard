//
//  UIViewController+restaurnat_detail_page.m
//  parse test
//
//  Created by Marco Hung on 8/2/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "restaurant_detail_page.h"
#import "rest_website.h"
#import "rest_addresslist.h"

@implementation restaurnat_detail_page
-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"shops:::%@ objectid:%@",self.rest_multishop, self.rest_objectid);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.title=@"優惠詳情";
    path = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
    plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    fav_rest_array = [plist objectForKey:@"fav_rest_id"];
    fav=NO;

    PFQuery *query = [PFQuery queryWithClassName:@"database20150712222"];
    [query getObjectInBackgroundWithId:self.rest_objectid block:^(PFObject *rest_details, NSError *error) {
        if(!error){
            self.rest_namez.text=rest_details[@"restaurant"];
            self.expirydatez.text=[NSString stringWithFormat:@"%@%@",@"有效期至",rest_details[@"enddate"]];
            if ([self.rest_multishop integerValue]>1){
                self.addressz.text =@"顯示分店列表";
            }else if ([rest_details[@"address"] length]>0){
                self.addressz.text=rest_details[@"address"];
                mapaddress=rest_details[@"address"];
            }else{
                self.addressz.text =@"發卡銀行未有提供地址記錄";
            };
            self.phonez.text=rest_details[@"tel"];
            phonenumber=[NSMutableString stringWithFormat:@"telprompt://%@",rest_details[@"tel"]];
            urladdress=rest_details[@"url"];
            
            if(urladdress.length>0){
            self.url_addressz.text =rest_details[@"url"];
            }else{
                self.url_addressz.hidden=YES;
                self.url_address_button.hidden=YES;
            }
            cardbank = rest_details[@"cardbank"];
            NSString *temps = [NSString stringWithFormat:@"%@%@",@"http://cardshk.com/cardsapp/picture/restaurant/allrestpic/",rest_details[@"picture"]];
            self.rest_picz.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:temps]]];
            if ([rest_details[@"remarks"] length]>0){
                NSString *html = [NSString stringWithFormat:@"%@%@%@%@%@",@"<p>",rest_details[@"description"],@"</p><span style=\"color:#696969;\"><span style=\"font-size:14px;\">註：<br><p>",rest_details[@"remarks"],@"</span></span></p>"];
                [self.mywebz loadHTMLString:html baseURL:nil];
            }else{
                NSString *html = [NSString stringWithFormat:@"%@%@%@",@"<p>",rest_details[@"description"],@"</p>"];
                [self.mywebz loadHTMLString:html baseURL:nil];
            }
            
            card_code_a = [NSMutableArray arrayWithArray:[rest_details[@"card_code"] componentsSeparatedByString:@","]];
            [card_code_a removeObject:@""];
            
            cellimagearray = [[NSMutableArray alloc] init];
            PFQuery *cardquery = [PFQuery queryWithClassName:@"creditcard"];
            [cardquery whereKey:@"card_code" containedIn:card_code_a];
            [cardquery findObjectsInBackgroundWithBlock:^(NSArray *cardobjects, NSError *error) {
                if(!error){
                    int i=0;
                    for (PFObject *cardobject in cardobjects) {
                        cellimagearray[i]=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cardobject[@"picurl"]]]];
                        i++;
                    }
                    [self.cardcolview reloadData];
                }
            }];
        }
    }];
}
-(void)viewDidAppear:(BOOL)animated{

    for (int i=0; i<fav_rest_array.count; i++) {
        if([self.rest_objectid isEqualToString:fav_rest_array[i]]){
            self.my_fav_pic.image=[UIImage imageNamed:@"red_heart_filled"];
  //          self.my_fav_word.text=@"已加入最愛";
            fav=YES;
        }
    }
}
- (IBAction)phonecall_button:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phonenumber]];

}

- (IBAction)map_button:(id)sender {
    NSLog(@"%@",self.addressz.text);
    if ([self.rest_multishop integerValue]>1){
        [self performSegueWithIdentifier: @"show_addresslist" sender:self];
    }else{
        if(![self.addressz.text isEqualToString:@"發卡銀行未有提供地址記錄"]){
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
                NSString *appmapaddress=[NSString stringWithFormat:@"comgooglemaps://?q=%@",mapaddress];
                appmapaddress = [appmapaddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appmapaddress]];
            }else{
                NSString *webmapaddress=[NSString stringWithFormat:@"http://maps.google.com/?q=%@",mapaddress];
                webmapaddress = [webmapaddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url = [NSURL URLWithString:webmapaddress];
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}

- (IBAction)my_fav_button:(id)sender {
    fav=!fav;
    if (fav){
        self.my_fav_pic.image=[UIImage imageNamed:@"red_heart_filled"];
 //       self.my_fav_word.text=@"已加入最愛";
        [fav_rest_array addObject:self.rest_objectid];
        
    }else{
        self.my_fav_pic.image=[UIImage imageNamed:@"red_heart"];
  //      self.my_fav_word.text=@"加入最愛";
        [fav_rest_array removeObject:self.rest_objectid];
    }
    [plist writeToFile:path atomically:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return cellimagearray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ccell";
    collectioncell *cell = (collectioncell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil){
        cell = [[collectioncell alloc]init];
    }
    cell.cardcellimage.image = cellimagearray[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"rest_website_segue"]) {
        rest_website *destViewController = segue.destinationViewController;
        destViewController.rest_urlz = urladdress;
        destViewController.rest_namez = self.rest_namez.text;
        
    }
    if ([segue.identifier isEqualToString:@"show_addresslist"]) {
        rest_addresslist *destaddressViewController = segue.destinationViewController;
        destaddressViewController.rest_address_name_z = self.rest_namez.text;
        destaddressViewController.rest_address_cardbank_z= cardbank;
    }
}
@end
