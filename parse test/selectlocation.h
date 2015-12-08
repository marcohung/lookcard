//
//  UIViewController+selectlocation.h
//  parse test
//
//  Created by Marco Hung on 7/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectlocation : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *total;
    NSMutableArray *hki;
    NSMutableArray *kln;
    NSMutableArray *nt;
    bool hkiselected;
    bool klnselected;
    bool ntselected;
    NSString *finallocation;
    NSString *finallocationdisplay;
    int hkicount;
    int klncount;
    int ntcount;

    
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *selectiontableviewz;
@property (weak, nonatomic) IBOutlet UILabel *finalanswerlabeldisplay;


@end
