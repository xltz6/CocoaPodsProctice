//
//  BaseTableViewController.h
//  HomePagePractice
//
//  Created by liuxuan on 2019/7/10.
//  Copyright © 2019 liuxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define segBarHeight 40
#define NaviBarHeight 64
#define headerImageHeight 200

NS_ASSUME_NONNULL_BEGIN
@protocol TableViewScrollProtocol <NSObject>

@required
- (void)tableViewScroll: (UITableView*) tableView offsetY: (CGFloat)offsetY;
- (void)tableViewWillBeginDragging: (UITableView*) tableView offsetY: (CGFloat)offsetY;
- (void)tableViewDidEndDragging: (UITableView*) tableView offsetY: (CGFloat)offsetY willDecelerate:(BOOL)decelerate;
- (void)tableViewWillBeginDecelerating: (UITableView*) tableView offsetY: (CGFloat)offsetY;
- (void)tableViewDidEndDecelerating: (UITableView*) tableView offsetY: (CGFloat)offsetY;

@end

@interface BaseTableViewController : UITableViewController

@property (nonatomic, weak) id<TableViewScrollProtocol> delegate;

@end



NS_ASSUME_NONNULL_END
