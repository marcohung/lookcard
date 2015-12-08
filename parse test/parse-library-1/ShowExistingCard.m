//
//  UIViewController+ShowExistingCard.m
//  parse test
//
//  Created by Marco Hung on 30/12/2014.
//  Copyright (c) 2014年 Ceasar Production. All rights reserved.
//

#import "ShowExistingCard.h"
#import "CustomCell.h"
#import "ShowCardDetails.h"

@implementation ShowExistingCard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://cardshk.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (!data){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Cellular Data is Turned Off" message:@"Turn on cellular data or use Wi-Fi to access data." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *SettingAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", @"OpenSetting") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // jump to setting when no internet is detected
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alertController addAction:SettingAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self firstaction];
    };
}

- (void)firstaction
{
    NSLog(@"firstaction");
    listpicz = [[NSMutableArray alloc] init];
    path = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
    plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    arrayz = [plist objectForKey:@"card"];
    NSLog(@"%@",arrayz);
    for (int i=0; i<arrayz.count; i++) {
        listpicz[i]=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arrayz[i] objectForKey:@"card_url"]]]];
    }
    [self.tableviewz reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.cardcounterlabel.text = [NSString stringWithFormat:@"%@%lu%@",@"你共有 ",(unsigned long)arrayz.count,@"/10 張信用卡"];
    return arrayz.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indicator = @"Cell";
    // 自定儲存格類別 setup
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:indicator];
    if (cell == nil) {
        // 載入 CustomCell.xib 檔
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        for (UIView *view in views) {
            if ([view isKindOfClass:[CustomCell class]]) {
                cell = (CustomCell *)view;
            }
        }
    }
    // 填資料到右標簽
    if (arrayz.count > 0){
        cell.cellpicturez.image = listpicz[indexPath.row];
        cell.rightLabel.text = [arrayz[indexPath.row] objectForKey:@"card_name"];
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//remove object in plist
    [arrayz removeObjectAtIndex:indexPath.row];
    [plist writeToFile:path atomically:YES];
//remove object in table array
    [listpicz removeObjectAtIndex:indexPath.row];
//remove in UI
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)editbuttonz:(UIBarButtonItem *)sender {
    if ([self.editbuttonoutlet.title isEqualToString:@"編輯"]) {
        [self.tableviewz setEditing:YES animated:YES];
        self.editbuttonoutlet.title = @"完成";
    }else{
        [self.tableviewz setEditing:NO animated:YES];
        self.editbuttonoutlet.title = @"編輯";
    }
    
}

//segue to show card details view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"show_existcard_details"]) {
        NSIndexPath *indexPath = [self.tableviewz indexPathForSelectedRow];
        ShowCardDetails *destViewController = segue.destinationViewController;
        destViewController.selectedcardsegue = [arrayz[indexPath.row] objectForKey:@"card_name"];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"show_existcard_details" sender: self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
