//
//  tabcontroller_z.m
//  parse test
//
//  Created by Marco Hung on 2/7/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//

#import "tabcontroller_z.h"

@implementation tabcontroller_z

-(void)viewDidLoad{
    listpicz = [[NSMutableArray alloc] init];
    path = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
    plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    arrayz = [plist objectForKey:@"card"];
    if (arrayz.count<1){
        self.selectedIndex = 2;
    }
}

@end