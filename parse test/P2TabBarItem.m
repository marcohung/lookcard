//
//  UITabBarItem+P2TabBarItem.m
//  parse test
//
//  Created by Marco Hung on 29/1/2015.
//  Copyright (c) 2015年 Ceasar Production. All rights reserved.
//
//THIS subclass: use to change the tab bar icon color to original icon color

#import "P2TabBarItem.h"

@implementation P2TabBarItem

- (void)awakeFromNib {
    [self setImage:self.image]; // calls setter below to adjust image from storyboard / nib file
}

- (void)setImage:(UIImage *)image {
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end

