//
//  BaseTableViewController.m
//  HomePagePractice
//
//  Created by liuxuan on 2019/7/10.
//  Copyright © 2019 liuxuan. All rights reserved.
//


// Table view controller: All three table views implement this table view controller
#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    // Create an empty white color UIView that has the same height with headerview. So that all three table views has this headerview.
    UIView *topHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerImageHeight + segBarHeight)];
    topHeadView.backgroundColor = [UIColor whiteColor];
    //Put head image and segment control above the table view as table header view.
    self.tableView.tableHeaderView = topHeadView;
    //set tableview contentInset
    if (self.tableView.contentSize.height < kScreenHeight + headerImageHeight - NaviBarHeight) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kScreenHeight + headerImageHeight - NaviBarHeight - self.tableView.contentSize.height, 0);
    }
    
}

#pragma mark - scrollView Delegate
// using ScrollView Delegate to know the offsetY of the scrolled table view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"%f", offsetY);
    // when delegate know scroll action communicate with tableView and later in ViewController file, according to the offsetY doing the different display.
    if ([self.delegate respondsToSelector:@selector(tableViewScroll:offsetY:)])
        [self.delegate tableViewScroll:self.tableView offsetY:offsetY];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if ([self.delegate respondsToSelector:@selector(tableViewWillBeginDragging:offsetY:)])
        [self.delegate tableViewWillBeginDragging:self.tableView offsetY:offsetY];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if ([self.delegate respondsToSelector:@selector(tableViewDidEndDragging:offsetY:willDecelerate:)])
        [self.delegate tableViewDidEndDragging:self.tableView offsetY:offsetY willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if ([self.delegate respondsToSelector:@selector(tableViewWillBeginDecelerating:offsetY:)])
        [self.delegate tableViewWillBeginDecelerating:self.tableView offsetY:offsetY];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if ([self.delegate respondsToSelector:@selector(tableViewDidEndDecelerating:offsetY:)])
        [self.delegate tableViewDidEndDecelerating:self.tableView offsetY:offsetY];
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
