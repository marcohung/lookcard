//
//  UIViewController+ShowExistingCard.h
//  parse test
//
//  Created by Marco Hung on 30/12/2014.
//  Copyright (c) 2014年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowExistingCard : UIViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *listpicz;
    NSString *path;
    NSMutableDictionary *plist;
    NSMutableArray *arrayz;
}
- (IBAction)editbuttonz:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editbuttonoutlet;
@property (weak, nonatomic) IBOutlet UITableView *tableviewz;
@property (weak, nonatomic) IBOutlet UILabel *cardcounterlabel;
@property (weak, nonatomic) IBOutlet UITableView *ExistingCardTableviewz;
@end
