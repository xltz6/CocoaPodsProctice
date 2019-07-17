//
//  MyWeiboHomePageViewController.m
//  MyWeiboHomePage
//
//  Created by Xuan Liu on 07/16/2019.
//  Copyright (c) 2019 Xuan Liu. All rights reserved.
//

#import "MyWeiboHomePageViewController.h"
#import "WeiboHomePageViewController.h"


@interface MyWeiboHomePageViewController ()

@end

@implementation MyWeiboHomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (IBAction)buttonClick:(id)sender {
    WeiboHomePageViewController *homePageVC = [WeiboHomePageViewController new];
    [self.navigationController pushViewController:homePageVC animated:YES];
}


@end
