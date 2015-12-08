//
//  UIViewController+showcarddetails.h
//  parse test
//
//  Created by Marco Hung on 31/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface rest_website : UIViewController <UIWebViewDelegate>
{
    NSString *rest_url;
    NSString *rest_name;
}
@property (nonatomic, strong) NSString *rest_urlz;
@property (nonatomic, strong) NSString *rest_namez;
@property (weak, nonatomic) IBOutlet UIWebView *myweb;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *rotor;

@end
