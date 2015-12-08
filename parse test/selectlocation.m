//
//  UIViewController+selectlocation.m
//  parse test
//
//  Created by Marco Hung on 7/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "selectlocation.h"

@implementation selectlocation

- (void)viewDidLoad {
    [super viewDidLoad];
    hki = [[NSMutableArray alloc] initWithObjects:@"香港島",nil];
    kln = [[NSMutableArray alloc] initWithObjects:@"九龍", nil];
    nt = [[NSMutableArray alloc] initWithObjects:@"新界", nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section){
        case 0:
            return hki.count;
        case 1:
            return kln.count;
        case 2:
            return nt.count;
        default:
            return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        UITableViewCell *headercell = [tableView dequeueReusableCellWithIdentifier:@"hkiheader"];
        switch(indexPath.section){
            case 0:
                headercell.textLabel.text = hki[indexPath.row];
                break;
            case 1:
                headercell.textLabel.text = kln[indexPath.row];
                break;
            case 2:
                headercell.textLabel.text = nt[indexPath.row];
                break;
        }
        return headercell;
    }
    else{
        UITableViewCell *hkicell = [tableView dequeueReusableCellWithIdentifier:@"hki"];
        switch(indexPath.section){
            case 0:
                hkicell.textLabel.text = hki[indexPath.row];
                break;
            case 1:
                hkicell.textLabel.text = kln[indexPath.row];
                break;
            case 2:
                hkicell.textLabel.text = nt[indexPath.row];
                break;
        }
        return hkicell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
    switch (indexPath.section){
        case 0:
            if (hki.count == 1){
                [hki addObjectsFromArray:[NSArray arrayWithObjects:@"香港島(全部)",@"銅鑼灣", @"中環", @"灣仔", @"大坑",@"北角",@"太古",@"鴨脷洲", nil]];

                NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
                for (int i=0;i<hki.count-1;i++){
                    [insertIndexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:0]];
                }
                [self.selectiontableviewz beginUpdates];
                [self.selectiontableviewz insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
                [self.selectiontableviewz endUpdates];
            }else{
                int tempcount = (int)hki.count;
                [hki removeAllObjects];
                [hki addObject:@"香港島"];
                NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];
                for (int i=0;i<tempcount-1;i++){
                    [deleteIndexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:0]];
                }
                [self.selectiontableviewz beginUpdates];
                [self.selectiontableviewz deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                [self.selectiontableviewz endUpdates];
            }
            break;
        case 1:
            if (kln.count == 1){
                [kln addObjectsFromArray:[NSArray arrayWithObjects:@"九龍(全部)",@"旺角",@"尖沙咀", @"佐敦",@"太子", @"九龍城", @"奧運站" , @"樂富",@"新蒲崗",@"九龍灣",@"觀塘", @"藍田", @"油塘", @"紅磡", @"長沙灣", nil]];
                NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
                for (int i=0;i<kln.count-1;i++){
                    [insertIndexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:1]];
                }
                [self.selectiontableviewz beginUpdates];
                [self.selectiontableviewz insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
                [self.selectiontableviewz endUpdates];
            }else{
                int tempcount = (int)kln.count;
                [kln removeAllObjects];
                [kln addObject:@"九龍"];
                NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];
                for (int i=0;i<tempcount-1;i++){
                    [deleteIndexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:1]];
                }
                [self.selectiontableviewz beginUpdates];
                [self.selectiontableviewz deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                [self.selectiontableviewz endUpdates];
            }
            break;
        case 2:
            if (nt.count == 1){
                [nt addObjectsFromArray:[NSArray arrayWithObjects:@"新界(全部)",@"上水", @"粉嶺", @"大埔", @"沙田",@"馬鞍山",@"大圍", @"屯門", @"荃灣",@"將軍澳", nil]];
                NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
                for (int i=0;i<nt.count-1;i++){
                    [insertIndexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:2]];
                }
                [self.selectiontableviewz beginUpdates];
                [self.selectiontableviewz insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
                [self.selectiontableviewz endUpdates];
            }else{
                int tempcount = (int)nt.count;
                [nt removeAllObjects];
                [nt addObject:@"新界"];
                NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];
                for (int i=0;i<tempcount-1;i++){
                    [deleteIndexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:2]];
                }
                [self.selectiontableviewz beginUpdates];
                [self.selectiontableviewz deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                [self.selectiontableviewz endUpdates];
            }
            break;
    }
    }else{
        //display result at tab
        switch (indexPath.section){
            case 0:
                finallocation=hki[indexPath.row];
                break;
            case 1:
                finallocation=kln[indexPath.row];
                break;
            case 2:
                finallocation=nt[indexPath.row];
                break;
        }
        finallocationdisplay = [NSString stringWithFormat:@"%@%@", @"地區:", finallocation];
        [[self.tabBarController.viewControllers objectAtIndex:2] setTitle:finallocationdisplay];
        //display reulst at header
        self.finalanswerlabeldisplay.text = [NSString stringWithFormat:@"%@%@", @"     當前選擇：", finallocation];
        //write to plist
        NSString *path = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
        NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        [plist setValue:finallocation forKey:@"location"];
        [plist writeToFile:path atomically:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
