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

-(void)loadView{
    [super loadView];
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s",__FUNCTION__);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__FUNCTION__);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s",__FUNCTION__);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%s",__FUNCTION__);
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%s",__FUNCTION__);
}

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}


- (IBAction)buttonClick:(id)sender {
    WeiboHomePageViewController *homePageVC = [WeiboHomePageViewController new];
    [self.navigationController pushViewController:homePageVC animated:YES];
}


@end
