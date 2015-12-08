//
//  UIViewController+restaurnat_detail_page.h
//  parse test
//
//  Created by Marco Hung on 8/2/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "collectioncell.h"

@interface restaurnat_detail_page: UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableString *phonenumber;
    NSString *mapaddress;
    NSString *path;
    NSMutableDictionary *plist;
    NSMutableArray *fav_rest_array;
    NSMutableArray *card_code_a;
    bool fav;
    NSMutableArray *cellimagearray;
    NSString *urladdress;
    NSString *cardbank;
}
@property (nonatomic, strong) NSString *rest_objectid;
@property (nonatomic, strong) NSNumber* rest_multishop;
@property (weak, nonatomic) IBOutlet UIWebView *mywebz;
@property (weak, nonatomic) IBOutlet UILabel *addressz;
@property (weak, nonatomic) IBOutlet UILabel *phonez;
@property (weak, nonatomic) IBOutlet UILabel *rest_namez;
@property (weak, nonatomic) IBOutlet UILabel *expirydatez;
@property (weak, nonatomic) IBOutlet UIImageView *rest_picz;
@property (weak, nonatomic) IBOutlet UILabel *url_addressz;
@property (weak, nonatomic) IBOutlet UIButton *url_address_button;



- (IBAction)phonecall_button:(id)sender;
- (IBAction)map_button:(id)sender;
- (IBAction)my_fav_button:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *my_fav_pic;


@property (weak, nonatomic) IBOutlet UICollectionView *cardcolview;


@end
