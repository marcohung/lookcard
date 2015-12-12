//
//  UIViewController+showcarddetails.m
//  parse test
//
//  Created by Marco Hung on 31/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "ShowCardDetails.h"

@implementation ShowCardDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedcard = _selectedcardsegue;
    self.navigationItem.title = selectedcard;
    self.myweb.delegate=self;
    [self.rotor startAnimating];
    PFQuery *query = [PFQuery queryWithClassName:@"creditcard"];
    [query whereKey:@"card" equalTo:selectedcard];
    [query findObjectsInBackgroundWithBlock:^(NSArray *ccobjects, NSError *error) {
        if(!error){
            for (PFObject *ccobject in ccobjects) {
                card_details_text=ccobject[@"details"];
            }
        }
        NSURL *url = [NSURL URLWithString:card_details_text];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.myweb loadRequest:request];
    }];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.rotor stopAnimating];
    self.rotor.hidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
