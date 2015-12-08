//
//  ViewController.h
//  parse test
//
//  Created by Marco Hung on 25/12/2014.
//  Copyright (c) 2014年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface cardsearch : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listz;
    NSMutableArray *listpic_urlz;
    NSMutableArray *listpicz;
    NSMutableArray *listcardcode;
    NSMutableArray *listowned;
    NSMutableArray *ownedcard;
    NSString *selectedbank;
    NSMutableDictionary *plist;
    NSString *path;
    NSMutableArray *arrayz;
    UIImage *greentick;
    UIImage *blackadd;
    NSInteger ownedcardcount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableviewz;
@property (nonatomic, strong) NSString *selectedbanksegue;
- (IBAction)save_card:(id)sender;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;
@property (nonatomic, strong) NSCache *imageCache;

@end

