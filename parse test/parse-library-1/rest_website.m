//
//  UIViewController+showcarddetails.m
//  parse test
//
//  Created by Marco Hung on 31/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "rest_website.h"

@implementation rest_website

- (void)viewDidLoad {
    [super viewDidLoad];
    rest_name = _rest_namez;
    rest_url = [NSString stringWithFormat:@"%@%@",@"http://",_rest_urlz];
    self.title=rest_name;
    self.myweb.delegate=self;
    [self.rotor startAnimating];
    NSURL *url = [NSURL URLWithString:rest_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myweb loadRequest:request];
    
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
