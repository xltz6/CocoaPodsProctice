//
//  WeiboHomePageViewController.m
//  微博个人主页
//
//  Created by liuxuan on 2019/7/17.
//  Copyright © 2019 LMIJKPlayer. All rights reserved.
//

#import "WeiboHomePageViewController.h"
#import "HeaderView.h"
#import "ProfileTableViewController.h"
#import "PostTableViewController.h"
#import "PhotoTableViewController.h"
#import "BaseTableViewController.h"
#import "HMSegmentedControl.h"
#import "ColorUtility.h"


@interface WeiboHomePageViewController () <TableViewScrollProtocol> {
    BOOL _stausBarColorIsBlack;
}

@property (nonatomic, weak) UIView *navView;
@property (nonatomic, strong) HMSegmentedControl *segCtrl;
@property (nonatomic, strong) HeaderView *headerView;

@property (nonatomic, strong) NSArray  *titleList;
@property (nonatomic, weak) UIViewController *showingVC;
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary *offsetYDict; // 存储每个tableview在Y轴上的偏移量

@end


@implementation WeiboHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //segment control title name array
    _titleList = @[@"主页", @"微博", @"相册"];
    
    // create scroll view for sliding to control segment
    [self createMainScrollView];
    //create navigation bar area on the top (after scrolling up, only show this navigation bar)
    [self configNav];
    //create three table views
    [self addController];
    //create head image and segment control parts
    [self addHeaderView];
    [self segmentedControlChangedValue:_segCtrl];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // set the background to transparency
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

#pragma mark create main UI component
// create and add the scroll view to the main view
- (void)createMainScrollView{
    _scrollview = [[UIScrollView alloc]init];
    _scrollview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _scrollview.backgroundColor = [UIColor whiteColor];
    _scrollview.scrollEnabled = YES;
    _scrollview.contentOffset = CGPointMake(0, 0);
    _scrollview.delegate = self;
    _scrollview.pagingEnabled = YES;
    _scrollview.bounces = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.contentSize = CGSizeMake(self.view.frame.size.width * 3, 0);
    [self.view addSubview:_scrollview];
}


// add Navigation bar on the top
- (void)configNav {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, NaviBarHeight)];
    navView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, kScreenWidth, 20)];
    titleLabel.text = @"我的主页";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    navView.alpha = 0;
    [self.view addSubview:navView];
    
    _navView = navView;
}


// add left, middle, right three table views
- (void)addController {
    ProfileTableViewController *vc1 = [[ProfileTableViewController alloc] init];
    vc1.delegate = self;
    PostTableViewController *vc2 = [[PostTableViewController alloc] init];
    vc2.delegate = self;
    PhotoTableViewController *vc3 = [[PhotoTableViewController alloc] init];
    vc3.delegate = self;
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
}

// Create HeadView and initialize the segement control
- (void)addHeaderView {
    HeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] lastObject];
    //header height image height (200) + segment control (40)
    headerView.frame = CGRectMake(0, 0, kScreenWidth, headerImageHeight+segBarHeight);
    headerView.nameLabel.text = @"我的主页";
    self.headerView = headerView;
    self.segCtrl = headerView.segControl;
    
    _segCtrl.sectionTitles = _titleList;
    _segCtrl.backgroundColor = [ColorUtility colorWithHexString:@"e9e9e9"];
    _segCtrl.selectionIndicatorHeight = 2.0f;
    _segCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segCtrl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segCtrl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segCtrl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [ColorUtility colorWithHexString:@"fea41a"]};
    _segCtrl.selectionIndicatorColor = [ColorUtility colorWithHexString:@"fea41a"];
    _segCtrl.selectedSegmentIndex = 0;
    _segCtrl.borderType = HMSegmentedControlBorderTypeBottom;
    _segCtrl.borderColor = [UIColor lightGrayColor];
    
    // add action to segCtrl, call segmentedControlChangedValue method
    [_segCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
}


#pragma mark -functional methods
- (void)segmentedControlChangedValue:(HMSegmentedControl*)sender {
    //set scroll view contentOffset: width * indexNumber and show the view
    [self.scrollview setContentOffset:CGPointMake(self.view.frame.size.width *sender.selectedSegmentIndex, 0) animated:NO];
    // display the child view with the selected index
    [self showChildVCViewsAtIndex:sender.selectedSegmentIndex];
    
}



// swipe to switch table views according to the index
- (void)showChildVCViewsAtIndex:(NSInteger)index {
    // check for invalid input index
    NSLog(@"first time");
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    // store index to global variable currentIndex
    _currentIndex = index;
    BaseTableViewController *vc = self.childViewControllers[index];
    vc.delegate = self;
    vc.view.frame = CGRectMake(self.view.frame.size.width * index, 0, self.scrollview.frame.size.width, self.scrollview.frame.size.height);
    //add table view to scroll view
    [self.scrollview insertSubview:vc.view belowSubview:self.navView];
    
    
    //get the current view pointer address, in order to get the offsetY from record dictionary
    NSString *addressStr = [NSString stringWithFormat:(@"%p"), vc];
    CGFloat offsetY = [_offsetYDict[addressStr] floatValue];
    vc.tableView.contentOffset = CGPointMake(0, offsetY);
    
    // for printing purpose
    NSLog(@"newVC offsetY : %f", offsetY);
    
    for(NSString *key in [_offsetYDict allKeys]) {
        NSLog(@"segment %f",[_offsetYDict[key] floatValue]);
    }
    
    // in two situation, set headerview to different position according to the current offsetY
    if (offsetY <= headerImageHeight - NaviBarHeight) {
        [vc.view addSubview:_headerView];
        for (UIView *view in vc.view.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [vc.view insertSubview:_headerView belowSubview:view];
                break;
            }
        }
        CGRect rect = self.headerView.frame;
        rect.origin.y = 0;
        self.headerView.frame = rect;
        
    }  else {
        [self.view insertSubview:_headerView aboveSubview:self.scrollview];
        CGRect rect = self.headerView.frame;
        rect.origin.y = NaviBarHeight - headerImageHeight;
        self.headerView.frame = rect;
    }
    _showingVC = vc;
    
}

#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // before going to another table view, record the current offset and update other child table view
    if (scrollView == self.scrollview) {
        BaseTableViewController *newVC = self.childViewControllers[_currentIndex];
        NSLog(@"scroll view");
        
        // update offset
        for (BaseTableViewController *childVC in self.childViewControllers) {
            if ([childVC isMemberOfClass:[self.showingVC class]]) {
                continue;
            }
            NSString *addressStr = [NSString stringWithFormat:@"%p", childVC];
            
            CGFloat offsetY = newVC.tableView.contentOffset.y;
            
            
            // when user drag down, keep offset 0
            if (offsetY < 0) {
                _offsetYDict[addressStr] = 0;
                
                // when user swipe up and segment control isn't next to the navigation bar (include the situation that just next to the navigation bar)
            } else if(offsetY <= headerImageHeight - NaviBarHeight && offsetY >= 0) {
                // update other child controllers to the same offset
                _offsetYDict[addressStr] = @(offsetY);
                
            }
            
            // when current offset is more than the top bar, we need to update the children views
            else {
                if (childVC.isViewLoaded){
                    if (childVC.tableView) {
                        
                        if (childVC.tableView.contentOffset.y > headerImageHeight - NaviBarHeight) {
                            _offsetYDict[addressStr] = @(childVC.tableView.contentOffset.y);
                        } else {
                            _offsetYDict[addressStr] = @(headerImageHeight - NaviBarHeight);
                        }
                    }
                }
            }
            
        }
        //         for(NSString *key in [_offsetYDict allKeys]) {
        //             NSLog(@"segment %f",[_offsetYDict[key] floatValue]);
        //         }
        
        // update view position
        if ([_headerView.superview isEqual:newVC.tableView ]) {
            [self.view insertSubview:_headerView aboveSubview:self.scrollview];
        }
        if (newVC.tableView.contentOffset.y > headerImageHeight - NaviBarHeight) {
            _headerView.frame = CGRectMake(0, - (headerImageHeight - NaviBarHeight), kScreenWidth, headerImageHeight + segBarHeight);
        }
        else{
            _headerView.frame = CGRectMake(0, - newVC.tableView.contentOffset.y, kScreenWidth, headerImageHeight + segBarHeight);
        }
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollview) {
        // after sliding the scroll view, we could get the index for choosing table view to show
        NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
        [self.segCtrl setSelectedSegmentIndex:index animated:YES];;
        [self showChildVCViewsAtIndex:index];
    }
}


//Create NSMutableDictionary to store the offsetY for three tableViewController
- (NSMutableDictionary *)offsetYDict{
    //if offsetDict is not exist, create new
    if (!_offsetYDict){
        NSLog(@"initialize");
        _offsetYDict = [NSMutableDictionary dictionary];
        for (BaseTableViewController *childVC in self.childViewControllers){
            //using addressStr as key for NSMutableDictionary, set initial value as minimum value of CGFloat
            //addressStr: convert pointer address to string
            NSString *addressStr = [NSString stringWithFormat: @"%p", childVC];
            _offsetYDict[addressStr] = @(CGFLOAT_MIN);
        }
    }
    return _offsetYDict;
}


#pragma mark - tableViewScroll Protocol BaseTabelView Delegate
- (void)tableViewDidEndDecelerating:(nonnull UITableView *)tableView offsetY:(CGFloat)offsetY {
    _headerView.userInteractionEnabled = YES;
    
    //after Decelerating we need to update the offsetDict
    NSString *addressStr = [NSString stringWithFormat:@"%p", _showingVC];
    if (offsetY > headerImageHeight - NaviBarHeight){
        // iterating the dictionary
        [self.offsetYDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            //update current child view
            if ([key isEqualToString:addressStr])
                self.offsetYDict[key] = @(offsetY);
            // update other child views
            else{
                if (!([self.offsetYDict[key] floatValue] == CGFLOAT_MIN) && [self.offsetYDict[key] floatValue] <= headerImageHeight - NaviBarHeight){
                    self.offsetYDict[key] = @(headerImageHeight - NaviBarHeight);
                }
            }
        }];
    }
    else{
        if (offsetY <= headerImageHeight - NaviBarHeight && offsetY >= 0) {
            [self.offsetYDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                self.offsetYDict[key] = @(offsetY);
            }];
        }
        if (offsetY < 0)
            self.offsetYDict[addressStr] = 0;
        
    }
    
    
}

- (void)tableViewDidEndDragging:(nonnull UITableView *)tableView offsetY:(CGFloat)offsetY willDecelerate:(BOOL)decelerate{
    _headerView.userInteractionEnabled = YES;
    //after dragging we need to update the offsetDict
    
    if (!decelerate) {
        NSString *addressStr = [NSString stringWithFormat:@"%p", _showingVC];
        if (offsetY > headerImageHeight - NaviBarHeight){
            [self.offsetYDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isEqualToString:addressStr])
                    self.offsetYDict[key] = @(offsetY);
                //            else if ([self.offsetYDict[key] floatValue] <= headerImageHeight - NaviBarHeight){
                //                self.offsetYDict[key] = @(headerImageHeight - NaviBarHeight);
                //            }
                else{
                    if (!([self.offsetYDict[key] floatValue] == CGFLOAT_MIN) && [self.offsetYDict[key] floatValue] <= headerImageHeight - NaviBarHeight){
                        self.offsetYDict[key] = @(headerImageHeight - NaviBarHeight);
                    }
                }
            }];
        }
        else{
            if (offsetY <= headerImageHeight - NaviBarHeight && offsetY >= 0) {
                [self.offsetYDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    self.offsetYDict[key] = @(offsetY);
                }];
            }
            if (offsetY < 0) {
                self.offsetYDict[addressStr] = @(segBarHeight);
            }
        }
        for(NSString *key in [_offsetYDict allKeys]) {
            NSLog(@"segment %f",[_offsetYDict[key] floatValue]);
        }
    }
}



- (void)tableViewScroll:(nonnull UITableView *)tableView offsetY:(CGFloat)offsetY {
    
    if (offsetY <= headerImageHeight - NaviBarHeight){
        //check if headerview is added as the subview of the tableview
        if (![_headerView.superview isEqual:tableView]){
            // adjust the position of the headerview to the top of the table view (y position 0)
            for (UIView *view in tableView.subviews){
                if ([view isKindOfClass:[UIImageView class]]){
                    [tableView insertSubview:_headerView belowSubview:view];
                    break;
                }
            }
        }
        CGRect rect = _headerView.frame;
        rect.origin.y = 0;
        _headerView.frame = rect;
        
    }
    //2.segment control next to the navigation bar
    else{
        //check if headerview is added as the subview of the navigation bar
        if(![_headerView.superview isEqual:self.view]){
            [self.view insertSubview:_headerView belowSubview:_navView];
            // set headerview position out of the showing screen
            CGRect rect = _headerView.frame;
            rect.origin.y = NaviBarHeight - headerImageHeight;
            _headerView.frame = rect;
        }
    }
    //adjust the navigation bar alpha value
    if (offsetY > 0){
        CGFloat alpha = offsetY/136;
        self.navView.alpha = alpha;
        
        if (alpha > 0.6 && !_stausBarColorIsBlack) {
            self.navigationController.navigationBar.tintColor = [UIColor blackColor];
            _stausBarColorIsBlack = YES;
            [self setNeedsStatusBarAppearanceUpdate];
        } else if (alpha <= 0.6 && _stausBarColorIsBlack) {
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            _stausBarColorIsBlack = NO;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else {
        self.navView.alpha = 0;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        _stausBarColorIsBlack = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
}

- (void)tableViewWillBeginDecelerating:(nonnull UITableView *)tableView offsetY:(CGFloat)offsetY {
    _headerView.userInteractionEnabled = NO;
}

- (void)tableViewWillBeginDragging:(nonnull UITableView *)tableView offsetY:(CGFloat)offsetY {
    _headerView.userInteractionEnabled = NO;
}

@end

