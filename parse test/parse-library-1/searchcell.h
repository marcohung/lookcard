//
//  CustomCell.h
//  Table
//
//  Created by Chiang Cheng-Han on 2014/7/27.
//  Copyright (c) 2014年 Ckk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchcell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellpicturez;
@property (weak, nonatomic) IBOutlet UILabel *celldetailz;
@property (weak, nonatomic) IBOutlet UIWebView *cellwebz;
@property (weak, nonatomic) IBOutlet UILabel *celladdressz;
@property (weak, nonatomic) IBOutlet UIImageView *bankimagez;

@end
