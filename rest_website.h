//
//  UIViewController+showcarddetails.h
//  parse test
//
//  Created by Marco Hung on 31/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface ShowCardDetails : UIViewController <UIWebViewDelegate>
{
    NSString *selectedcard;
    NSString *cardbank;
    NSString *card_details_text;
    NSString *card_pic_url;
}
@property (nonatomic, strong) NSString *selectedcardsegue;
@property (weak, nonatomic) IBOutlet UIWebView *myweb;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *rotor;

@end
