//
//  UIViewController+search_district.m
//  parse test
//
//  Created by Marco Hung on 6/2/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "search_district.h"
#import "restaurantsearch.h"
@implementation search_district


- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableArray *hk_whole = [[NSMutableArray alloc] initWithObjects:@"全香港",nil];
    NSMutableArray *hki_whole =[[NSMutableArray alloc] initWithObjects:@"香港島(全部)",nil];
    NSMutableArray *hki_central =[[NSMutableArray alloc] initWithObjects:@"中環",@"香港站",@"上環",@"金鐘",@"半山",@"山頂",@"西環",@"西營盤",@"堅尼地城",nil];
    NSMutableArray *hki_wanchai =[[NSMutableArray alloc] initWithObjects:@"灣仔",@"銅鑼灣",@"大坑",@"跑馬地",nil];
    NSMutableArray *hki_east =[[NSMutableArray alloc] initWithObjects:@"鰂魚涌",@"太古城",@"天后",@"炮台山",@"北角",@"筲箕灣",@"西灣河",@"杏花村",@"小西灣",@"柴灣",nil];
    NSMutableArray *hki_south =[[NSMutableArray alloc] initWithObjects:@"赤柱",@"香港仔",@"數碼港",@"鴨脷洲",@"黃竹坑",@"淺水灣",@"薄扶林",nil];
    hki_head =[[NSMutableArray alloc] initWithObjects:@"全香港",@"香港島",@"中西區",@"灣仔區",@"東區",@"南區",nil];
    hki = [[NSMutableArray alloc] initWithObjects:hk_whole,hki_whole,hki_central,hki_wanchai,hki_east,hki_south,nil];
    
    NSMutableArray *kln_whole =[[NSMutableArray alloc] initWithObjects:@"九龍(全部)",nil];
    NSMutableArray *kln_ymt =[[NSMutableArray alloc] initWithObjects:@"尖沙咀",@"旺角",@"佐敦",@"油麻地",@"太子",@"九龍站",@"柯士甸",@"大角咀",@"奧運",@"南昌",nil];
    NSMutableArray *kln_klncity=[[NSMutableArray alloc] initWithObjects:@"九龍城",@"紅磡",@"何文田",@"土瓜灣",@"九龍塘",nil];
    NSMutableArray *kln_ssp=[[NSMutableArray alloc] initWithObjects:@"美孚",@"深水埗",@"長沙灣",@"荔枝角",@"石硤尾",nil];
    NSMutableArray *kln_wts=[[NSMutableArray alloc] initWithObjects:@"彩虹",@"黃大仙",@"鑽石山",@"新蒲崗",@"鑽石山",@"樂富",nil];
    NSMutableArray *kln_kt=[[NSMutableArray alloc] initWithObjects:@"九龍灣",@"牛頭角",@"觀塘",@"鯉魚門",@"藍田",@"油塘",nil];
    kln_head =[[NSMutableArray alloc] initWithObjects:@"全香港",@"九龍",@"油尖旺區",@"九龍城區",@"觀塘區",@"深水埗區",@"黃大仙區",nil];
    kln = [[NSMutableArray alloc] initWithObjects:hk_whole,kln_whole,kln_ymt,kln_klncity,kln_kt,kln_ssp,kln_wts,nil];
    
    NSMutableArray *nt_whole=[[NSMutableArray alloc] initWithObjects:@"新界(全部)",nil];
    NSMutableArray *nt_tw=[[NSMutableArray alloc] initWithObjects:@"荃灣",@"深井",@"汀九",@"珀麗灣",@"愉景灣",nil];
    NSMutableArray *nt_kt=[[NSMutableArray alloc] initWithObjects:@"青衣",@"葵芳",@"葵興",@"葵涌",nil];
    NSMutableArray *nt_shatin=[[NSMutableArray alloc] initWithObjects:@"大圍",@"沙田",@"火炭",@"馬鞍山",@"大學",nil];
    NSMutableArray *nt_taipo=[[NSMutableArray alloc] initWithObjects:@"大埔",@"太和",nil];
    NSMutableArray *nt_north=[[NSMutableArray alloc] initWithObjects:@"粉嶺",@"上水",@"落馬洲",@"羅湖",nil];
    NSMutableArray *nt_yl=[[NSMutableArray alloc] initWithObjects:@"元朗",@"天水圍",@"朗屏",nil];
    NSMutableArray *nt_tm=[[NSMutableArray alloc] initWithObjects:@"屯門",@"黃金海岸",nil];
    NSMutableArray *nt_saikung=[[NSMutableArray alloc] initWithObjects:@"將軍澳",@"坑口",@"西貢",nil];
    NSMutableArray *nt_island=[[NSMutableArray alloc] initWithObjects:@"香港國際機場",@"東涌",@"南丫島",@"梅窩",nil];
    nt_head =[[NSMutableArray alloc] initWithObjects:@"全香港",@"新界",@"西貢區",@"荃灣區",@"葵青區",@"離島區",@"沙田區",@"大埔區",@"北區",@"元朗區",@"屯門區",nil];
    nt = [[NSMutableArray alloc] initWithObjects:hk_whole,nt_whole,nt_saikung,nt_tw,nt_kt,nt_island,nt_shatin,nt_taipo,nt_north,nt_yl,nt_tm,nil];

    district_head = hki_head;
    district = hki;
    
    if ([self.usersearchinput length]>0){
        self.search_text.text = self.usersearchinput;
    };
    if ([self.user_searchdistrict length]>0){
        selected_district = [NSMutableString stringWithFormat:@"%@",self.user_searchdistrict];
    }else{
        selected_district = [NSMutableString stringWithString:@"全香港"];
    }
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor whiteColor];
    header.backgroundView.backgroundColor= [UIColor colorWithRed:0/255.0f green:170/255.0f blue:195/255.0f alpha:1.0f];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *temparray = [[NSMutableArray alloc]init];
    temparray = district[section];
    return temparray.count;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return district.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return district_head[section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *hkicell = [tableView dequeueReusableCellWithIdentifier:@"hki"];
    hkicell.textLabel.text = district[indexPath.section][indexPath.row];    
    if ([selected_district isEqualToString:district[indexPath.section][indexPath.row]])
    {
        hkicell.accessoryType = UITableViewCellAccessoryCheckmark;
        selected_indexpath=indexPath;
    }else{
       hkicell.accessoryType = UITableViewCellAccessoryNone;
    }
    return hkicell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //remove the old checkmark
    if (selected_indexpath == nil)
    {
        selected_indexpath = [[NSIndexPath alloc]init];
    }else{
        UITableViewCell *oldselcetedcell = [tableView cellForRowAtIndexPath:selected_indexpath];
        oldselcetedcell.accessoryType = UITableViewCellAccessoryNone;
    };
    
    //display the new checkmark
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //set dataset for new checkmark
    selected_indexpath=indexPath;
    selected_district = [NSMutableString stringWithFormat:@"%@",cell.textLabel.text];
}


- (IBAction)segmentchange:(UISegmentedControl *)sender {
    //hide keyboard when segment change
    [self.view endEditing:YES];

    [self.districttablez beginUpdates];
    for (int i=0; i<district_head.count;i++){
        [self.districttablez deleteSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationRight];
    };
    district_head = nil;
    district = nil;
    [self.districttablez endUpdates];
    switch(sender.selectedSegmentIndex){
        case 0:
            district_head = hki_head;
            district = hki;
            selected_district = [NSMutableString stringWithString:@"全香港"];

            break;
        case 1:
            district_head = kln_head;
            district = kln;
            selected_district = [NSMutableString stringWithString:@"全香港"];
            break;
        case 2:
            district_head = nt_head;
            district = nt;
            selected_district = [NSMutableString stringWithString:@"全香港"];
            break;
    }
    
    [self.districttablez reloadData];
}

//hide keyboard if user press "enter"
- (IBAction)searchbar_finish:(id)sender {
    [self.view endEditing:YES];
}
//hide keyboard if user scroll table
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


//prepare sending data for segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"search_restaurant"]) {
        restaurantsearch *destViewController = segue.destinationViewController;
        destViewController.usersearchinput = self.search_text.text;
        destViewController.user_searchdistrict=selected_district;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end



/*
 famoushead = [[NSMutableArray alloc] initWithObjects:@"銅鑼灣",@"上環",@"山頂",@"中環",@"太古",@"北角",@"赤柱",@"金鐘",@"柴灣",@"灣仔",@"香港仔",@"薄扶林",@"鰂魚涌",nil];
 NSMutableArray *famous_cwb = [[NSMutableArray alloc] initWithObjects:@"皇室堡",@"駱克駅",@"世貿中心",@"永光中心",@"亨利中心",@"希慎廣場",@"京都廣場",@"恒隆中心",@"時代廣場",@"渣甸中心",@"黃金廣場",@"利舞臺廣場",@"金百利廣場",@"金利文廣場",@"永光商業大廈",@"伊利莎伯大廈",@"澳門逸園中心",@"Midtown",@"銅鑼灣崇光百貨",@"銅鑼灣廣場一期",@"銅鑼灣廣場二期",@"利園 (嘉蘭中心)",@"Fashion Walk",nil];
 NSMutableArray *famous_sheungwan = [[NSMutableArray alloc] initWithObjects:@"西港城",@"柏廷坊",@"信德中心",@"無限極廣場",@"新紀元廣場",@"上環市政大廈",nil];
 NSMutableArray *famous_peak = [[NSMutableArray alloc] initWithObjects:@"凌霄閣",@"山頂廣場",nil];
 NSMutableArray *famous_central = [[NSMutableArray alloc] initWithObjects:@"大會堂",@"娛樂行",@"7號碼頭",@"太子大廈",@"交易廣場",@"怡和大廈",@"萬宜大廈",@"置地廣場",@"新世界大廈",@"國際金融中心",nil];
 NSMutableArray *famous_wanchai = [[NSMutableArray alloc] initWithObjects:@"大有商場",@"北海中心",@"合和中心",@"胡忠大廈",@"海港中心",@"鵝頸街市",@"新鴻基中心",@"英皇集團中心",@"會議展覽中心",@"駱克道市政大廈",@"QRE Plaza",@"灣景中心 (Brim 28)",nil];
 famous = [[NSMutableArray alloc] initWithObjects:famous_cwb,famous_sheungwan,famous_peak, famous_central,famous_wanchai, nil];
 
*/
